## car_023_war

So just so I understand correctly - You want to change an **existing** card?

I'll explain using your example card `car_023_war`:
1. Text and Language
   1. Create an `language` folder in your `ccg_mod` folder and create a file called `en.utf8` 
      - Exchange `en` for any other language.
      - Make sure your file is not an `.txt` file. [Should look like this.](https://github.com/Actilu/hellcard-modding-reference/wiki/Language-Files#file-type)
   2. Inside that file you place your language keys and translations. Thats the part you already did: <br> 
      ```
      car_023_war_title = "Crystal Sword"
      car_023_war_desc  = "Deal \1 damage. If this kills the monster, increase the damage of this card by \5."
      ```
      - Have a look at the modding console if there are any errors regarding this.
2. Replace **existing** card:
   1. To replace a existing card, you have to add an card with the **same name** into the **same card group**.
   2. So the card `car_023_war` is in the group `warrior` with the class warrior.
      1. Go into the editor. And under `Hellcard Game > Managers > Cards > Mod > Groups` add a new group called `warrior` and change its class to warrior.
      2. In your `warrior > Cards` add a new card or copy `car_023_war` change its name to `car_023_war`.

3. Functionality
   1. Change the `car_023_war` you added in step 2. 
   2. You wanted to have that card increase its damage on kill.
   3. To do that you only have to change `Mod > Groups > warrior > Cards > car_023_war > OnPlay > Attack > Blocks on peak > Damage > Blocks on target death > LowerDmg`.
   4. Click on `LowerDmg` and change `Operation` from Substract to **Add**.


## car_101_rog

Look at the card `car_101_rog` in the editor and try to understand how it works. [Functionality for each card block can be seen here](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/CreatingNewCard.md#behaviors).

- **"Deal \1 damage to all monsters with move or flank intents."**
  - This should be quite simple. I divided the functionality into 2 parts. We have to:
    1. Search for all monsters that want to move or flank -> **our targets**
    2. Deal x damage to these target monsters
  - For now you can **ignore** all Blocks that are:
    - called `~FX` or 
    - are in the `Effects on ~` folder.
    - These Blocks only change particles and visuals.
  - This leaves us with only 2 CardBlocks: `BCCGTargetSelectCardBlock` called `SelectTargets` and `BCCGDamageCardBlock` called `Damage copy`.
    - Now as you want to change the target selection from move/flank to attack, you have to change something in the `SelectTargets` block.
    - Try going through each Object Param in that block to understand its function.
      - For example 
        - *"`Targets`: AllMonsters"* selects all monsters currently in the dungeon.
        - *"`Range`: Anywhere"* filters these monster to be in near and far range.

Try to work it out yourself first, but if you want here is the solution for your problem:<br>
|| Set Object Param `Filters > Intent` in `SelectTargets` to `BCCGMonsterAttackAction` ||

## car_067_rog

Changing "car_067_rog_title = "Hot Potato" to:<br>
`car_067_rog_desc  = "All heroes get \5 mana and draw each time you detonate a \s5^debf56Bomb^^. ^debf56Exhaust^^."`

What you want is really hard to do and you probably need to code your own influence.

Here is a small introduction on **influence cards and influences**:

If you want to do something in the game that needs to happen on a later turn or happens over a number of turns you need to use influences.
Thats because cards can only control things that are present at the time the card is played. You cant deal damage to a monster in 5 turns with only `BCCG~CardBlocks`

For that you need to push (add an influence to your character). Thats mostly done with influence cards, but attack or skill cards can add influences aswell.
**Influences** can exist over several rounds or until you win or lose the floor.
Cards push these influences with `BCCGInfluencePushCardBlock`. In the cardblock you have to specify which influence you want to push. After that the influence does all the work and the card is no longer needed.
[How to create your own influences is documented on github](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/CreatingNewInfluence.md).

If you create a new influence you have to choose a `Class Name` in the Object Params. This class specifies what the influence can do.
So if you create a new influence and use the `BCCGHotPotatoInfluence` Class it uses the same logic as the existing Hot Potato influence and you can change 2 parameters:
- Functionality of the hot potato influence is:
  - If you detonate a bomb card (= card with bomb id), then all heroes get 1 mana and the player that played hot potato gets a random bomb card (= card with bomb tag) to the draw pile.
- The 2 parameters
1. `GivenCardTag`
   - tag of the card that is added to the draw pile (= card with bomb tag)
2. `Tracked card id`
   - id of the card that is detonated (= card with bomb id)
These are the only things you can change in the editor.

If you want to change what happens when a bomb detonates, you need to create a new influence with a `BCCGAngelScriptInfluence` class. Code everything the existing one does, as well as your new behaviors. This would be kinda hard but you can read about [angelscript influences on github](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/AngelScriptInfluences.md).