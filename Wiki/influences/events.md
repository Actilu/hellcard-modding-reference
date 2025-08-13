There are 20 EventTypes that can be used by Influences.:

| EventType                                            | Description                                                             |
| ---------------------------------------------------- | ----------------------------------------------------------------------- |
|@BCCG_BATTLE_SHOW_CARD                     | Sends when player shows card, it defines that player started targetting |
|@BCCG_BATTLE_SOMEONE_PLAYED_CARD           | Sends when player played card                                           |
|@BCCG_INFLUENCE_ABOUT_TO_BE_REMOVED        | Sends when influence should be removed                                  |
|@BCCG_INFLUENCE_PUSH_EVT                   | Sends when influence push method has been invoked                       |
|@BCCG_DUNGEON_CONTROLLER_ENDED             | Sends when controller has ended                                         |
|@BCCG_DUNG_MONSTER_KILLED                  | Sends when monster has been killed                                      |
|@BCCG_CHAR_DUNG_COMPONENT_CARD_MOVED       | Sends when card has been moved                                          |
|@BCCG_DUNG_CHARACTER_KILLED                | Sends when character has been killed                                    |
|@BCCG_CHAR_DUNG_COMPONENT_CARD_ADDED       | Sends when card was added to character                                  |
|@BCCG_CHAR_DUNG_COMPONENT_PARAM_CHANGED    | Sends when character params has been changed                            |
|@BCCG_BATTLE_CARD_PLAYED                   | Sends when card was played                                              |
|@BCCG_DUNGEON_CONTROLLER_STARTED           | Sends when controller has started                                       |
|@BCCG_BATTLE_HIDE_CARD                     | Sends when player has hide the card                                     |
|@BCCG_CHAR_DUNG_COMPONENT_DISCARD_SHUFFLED | Sends when character discarder or shuffled cards                        |
|@BCCG_INFLUENCE_INSTANCE_CHANGED           | Sends when influence instance has been changed                          |
|@BCCG_INFLUENCE_GROUP_CHANGED              | Sends when influence group has been changed                             |
|@BCCG_INFLUENCE_INSTANCE_USED              | Sends when influence has been used                                      |
|@BCCG_STUDY_COST_CHANGED                   | Sends when study cost has been changed                                  |
|@BCCG_BATTLE_REQUEST_CARD_MOVE             | Sends when card has been moved                                          |
|@BCCG_PROCESS_CARD_MOVE_REQUESTS_EVT       | Sends after card move                                                   |

# Usage:

``` as
int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
{
  // Get current event type from event
  EventType@ type = evt.GetEventType();

  // Check if event type is the one you want
  if(type is @BCCG_BATTLE_SOMEONE_PLAYED_CARD)
  {
    // Check if player has the influence and is local player
    BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
    BCCGCardContext@ cont = card_evt.GetContext();
    BCCGCharacterObj@ character = cont.m_pCharInst;
    if(character.GetId() != influence.GetLinkedCharacterId() 
        || !character.IsOwnedByLocalPlayer())
        return 1;
    
    // Do stuff here:
  }
}
```