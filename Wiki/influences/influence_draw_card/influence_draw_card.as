class Influence
{
    bool IsGlobal(){return false;}
    bool ShouldDisplayCounter(){return false;}
    bool HasWidget(){return false;}

    string draw_influence_tag = "draw_card";
    string draw_influence_name = "test_draw_card_engine_transmission_belt";

    int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
    {
        EventType@ type = evt.GetEventType();

        if(type == @BCCG_BATTLE_SOMEONE_PLAYED_CARD)
        {
            BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
            BCCGCardContext@ cont = card_evt.GetContext();

            BCCGCharacterObj@ character = cont.m_pCharInst;

            if(character.GetId() != influence.GetLinkedCharacterId() 
               || !character.IsOwnedByLocalPlayer())
                return 1;

            // push draw_influence for the first time
            if (CardHasTag(cont.m_pClass, "activation"))
            {
                BCCGInfluenceInstanceBase@ drawInfluence = FindPushedInfluenceByTag(draw_influence_tag, influence.GetLinkedCharacterId());
                // if counter greater than treshold and metamorphosis influence is not present
                if(drawInfluence == null)
                {
                    PushInfluenceByName(GetDungeon(), draw_influence_name, character);
                }
            }
            
            // somewhere in code (example: after player played a card with draw_card tag)
            if (CardHasTag(cont.m_pClass, "draw_card"))
            {
                PushInfluenceByName(GetDungeon(), draw_influence_name, character);
            }

        }
        return 1;
    }
}

Influence@ CreateInfluence()
{
    return Influence();
}