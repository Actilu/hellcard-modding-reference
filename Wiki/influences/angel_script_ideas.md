## EventType
> In official docs I found EventType BCCG_DUNG_MONSTER_KILLED, but which methods would have Event with this EventType?

Ill start with this one. As `EventType` is probably the answer to most of your questions.
The [documentation on AngelScriptInfluences](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/AngelScriptInfluences.md#event-management) mentions Event management at the very bottom.

With the mentioned method `int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)` you can receive events and do stuff based on `EventType`.

You could do something like this:

```
int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
{
    // get event type
    EventType@ type = evt.GetEventType();

    // check if event type is type you want to work with
    if(type is @BCCG_DUNG_MONSTER_KILLED)
    {
        // check if your own character owns this influence ans is local player
        BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
        BCCGCardContext@ cont = card_evt.GetContext();
        BCCGCharacterObj@ character = cont.m_pCharInst;
        if(character.GetId() != influence.GetLinkedCharacterId() 
            || !character.IsOwnedByLocalPlayer())
            return 1;
        
        // your logic implementation:
    }

    return 1;
}
```

## Event types and Push Influences
> I want to push influence when some monster is killed


As you have probably already seen, the event types are listed in [predefined.as](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/mod_hexer/ccg_mod/3350421454/scripts/as.predefined).

And as you already already said, `BCCG_DUNG_MONSTER_KILLED` triggers when any monster is killed.

So use the code from above and add something like this to push an influence:

```
// your logic implementation:

// your influences tag and name
string yourBaseTag = "your_influence_tag";
string yourInfluenceName = "your_influence";

// check if influence is already present
BCCGInfluenceInstanceBase@ yourInfluence = FindPushedInfluenceByTag(yourBaseTag, influence.GetLinkedCharacterId());
if(poisonInfluence == null)
{
    // find influence and create instance
    BCCGInfluenceClass@ addedInfluence = FindInfluence(yourInfluenceName);
    BCCGInfluenceInstanceBase@ newInfluence = CreateInfluenceInstance(addedInfluence, influence.GetLinkedCharacterId());
    
    // do stuff like setCounter
    newInfluence.SetCounter(counter);

    // push your influence
    PushInfluence(GetDungeon(), newInfluence, cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId())));

    // release instance
    Release(newInfluence);
    return 1;
}
```

Seems a little complicated but might cover some edge cases

## Card behavior depending on Influence count
> change card behavior depending on influence count

Depends on what you want to do. The easiest and probably best way are normal [CardBlocks](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/CreatingNewCard.md#behaviors).

1. The `BCCGCountInfluenceCardBlock` counts the number of stacks a specific active influence has and saves it in a card channel.
2. Now you can work with that number. 
   1. You could for example deal damage based on influence stacks if you save the count in the damage channel and use `BCCGDamageCardBlock` to deal damage based on the number in the damage channel.
   2. Or you could use `BCCGLogicCardBlock` to compare that number with another number or channel. And than do somthing like: if the stacks are over 100 draw 5 cards otherwise draw only 1.

## Add controller/code to cards or characters
> possibility to add some controllers to card and characters through code, because I saw some types, that could work, but I didn't found possibility to add AngelScript directly to card/character. 

I dont think there is a way for us to add code directly to characters or cards. 
But you can just use influences to do this for you. 

1. **Cards:** 
   - Push Influences with `BCCGInfluencePushCardBlock` on draw or play. And let that influence do all the things your card should do.
2. **Characters:** 
   - Add **starting** artifact to character that just pushes your influence
   - Make influence **invisible** with `bool HasWidget(){return false;}`
   - Look at the influence `poison_master` and `influence_poison_master.as` and the artifact `poisonmaster` for more infos.

## Remove influence at the start of the turn

I would probably do something like this:

``` as
void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
{
    if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
        return;
    
    influence.ForceRemove();
}
```

## Drawing a card by script

What we need:
1. Influence that holds your script and logic - `test_draw_master`
   - Needs to be present and controls the other influence. (mine is invisible)
   - I will push it with a card action. (`card_test_draw_master`)
   - It pushes the second influence for the first time.
   - Controls when to draw the card.
     - In this example when playing a card with the `draw_card` tag.
2. Influence that draws card for us when pushed beyond the first time. - `test_draw_card_engine_transmission_belt`
   - Class Name: `BCCGTransmissionBeltInfluence`
   - Tag and Contraption Tag Param must be the same

To activate the influence and draw a card I just play a card with the chosen tag and the master influence pushes the transmission belt and it then drwas a card.

