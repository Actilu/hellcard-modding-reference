// This influence should be added to a character starter artefact as BCCGInfluencePushBehaviour.
// It will be invisible and controls other influences and interactions.

// functionality:
// - when player plays a card with `cardTag` variable, it will push an influence with `influenceTag` and `influenceName`
//      - amount pushed is based on Card Params Channel `cardParam`
// - when player kills a monster with a specific family name, it will push an influence with `influenceTag` and `influenceName`
//     - amount pushed is based on `stacksOnKill` variable

// you can enable debug messages by setting `debugMode` to true

class Influence
{
    // make influence invisible
    // Override
    bool HasWidget() 
    { 
        if(debugMode)
        {
            Print(debugPrefix + "HasWidget called");
            return true;
        }
        return false; 
    }

    // Override
    bool ShouldDisplayCounter() {  return false; }
    // Override
    bool IsGlobal() { return false; }

    // Override
    int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
    {
        if(debugMode)
        {
            Print(debugPrefix + "ProcessEvent called");
        }

        EventType@ type = evt.GetEventType();

        // check if someone played a card
        if(type is @BCCG_BATTLE_SOMEONE_PLAYED_CARD)
        {
            if(debugMode)
            {
                Print(debugPrefix + "Event type: Someone played a card");
            }

            BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
            BCCGCardContext@ cont = card_evt.GetContext();
            BCCGCharacterObj@ character = cont.m_pCharInst;

            // check id local player played that card
            if(character.GetId() != influence.GetLinkedCharacterId() 
               || !character.IsOwnedByLocalPlayer())
                return 1;

            if (debugMode) {
                Print(debugPrefix + "Local player played a card");
            }

            // check if card has specific tag
            if(CardHasTag(cont.m_pClass, cardTag))
            {
                if(debugMode)
                {
                    Print(debugPrefix + "Card has tag: " + cardTag);
                }
                if(cardParam != 0)
                {
                    stacksOnCardPlay = cont.m_pParams.GetParam(cardParam);
                }
                pushInfluence(counter + stacksOnCardPlay, influence);
            }
        }
        return 1;
    }

    // Override
    void OnMonsterKilled(BCCGDungeon@ dung, BCCGMonsterObj@ monster, BodDungObj@ killer, BCCGCardContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(debugMode)
        {
            Print(debugPrefix + "OnMonsterKilled called");
            Print(debugPrefix + "Monster family: " + monster.GetFamily());
        }
        // check if monster has specific family and push influence if it has
        if(monster.GetFamily() == monsterFamily)
            pushInfluence(counter + stacksOnKill, influence);
    }

    // Original function to push influence
    void pushInfluence(int val, BCCGInfluenceInstanceBase@ influence)
    {
        if(debugMode)
        {
            Print(debugPrefix + "PushInfluence called with value: " + val);
        }
        // set counter
        counter = val;

        // check if influence already exists
        BCCGCharacterObj@ character = cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId()));
        if(character == null)
            return;
        BCCGInfluenceInstanceBase@ existingInfluence = FindPushedInfluenceByTag(influenceTag, influence.GetLinkedCharacterId());

        // if counter is greater than 0 and influence does not exist, create it
        if(counter > 0 && existingInfluence == null)
        {
            if(debugMode)
            {
                Print(debugPrefix + "Creating new influence instance");
            }
            BCCGInfluenceClass@ addedInfluence = FindInfluence(influenceName);
            BCCGInfluenceInstanceBase@ newInfluence = CreateInfluenceInstance(addedInfluence, influence.GetLinkedCharacterId());
                
            newInfluence.SetCounter(counter);

            PushInfluence(GetDungeon(), newInfluence, character);

            Release(newInfluence);
            return;
        }

        // if counter is less than or equal to 0 and influence exists, remove it
        if (counter <= 0 && existingInfluence != null)
        {
            if(debugMode)
            {
                Print(debugPrefix + "Removing existing influence instance");
            }
            existingInfluence.ForceRemove();
            return;
        }

        // if counter is less than or equal to 0 and influence does not exist, do nothing
        if(counter <=0 && existingInfluence == null)
            return;

        if(debugMode)
        {
            Print(debugPrefix + "Updating existing influence instance");
        }

        // if influence exists, set counter
        existingInfluence.SetCounter(counter);
    }

    // Get the current counter value
    int GetCounter()
    {
        return counter;
    }

    // Properties
    int counter = 1; // starting counter

    string cardTag = "card_tag"; // replace with actual card tag to be checked
    string influenceTag = "influence_tag"; // replace with actual influence tag to be pushed
    string influenceName = "influence_name"; // replace with actual influence name that will be pushed

    string monsterFamily = "spiders"; // replace with actual monster family name
    int stacksOnKill = 1; // number of stacks to add on kill

    int stacksOnCardPlay = 1; // number of stacks to add on card play will be replaced with actual value from card params
    BCCGCardParam cardParam = BCCGCardParam::MagicNum1; // replace with actual card param channel if not 0

    bool debugMode = false; // set to true to enable debug messages
    string debugPrefix = "##### Debug ##### - Character Influence Master: "; // prefix for debug messages
} 

Influence@ CreateInfluence()
{
    Print("Creating character_influence_master instance");
    return Influence();
}