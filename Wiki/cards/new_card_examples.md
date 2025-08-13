So you want to do the add the following card:

- influence card
- exhaust
- x cards above 15 in deck(just deck or gy and hand?)
  - draw x more on turn begin
  - bolts deal x more dmg

- Influence card that does something on each turn begin
  - Influence cards always push/add an influence to the character that does all the work, as cards can only affect things that are present at the time the card is played.
- So your card has to look something like this:
  - `BCCGInfluencePushCardBlock` that adds an influence
  - `BCCGCardMoveCardBlock` to move the used card to the exhaust pile

The big problem is now what influences to choose or if you need to code your own.
Influence has to have this functionality on turn begin:
1. Get `cards_in_deck = number of cards in deck/draw-pile`.
2. `x = cards_in_deck - 15`
3. If `x > 0` then:
   1. Draw x
   2. Bolts deal +x damage

I dont think there is an vanilla influence for `Step 1, 2 and 3`, so you have to code something yourself if im not mistaken.
- Add other influence on turn begin:
  - `BCCGAddRandomInfluenceEachTurnInfluence`
As you already said drawing on turn begin and bolts dealing more damage could be done with existing influences.
1. Draw cards:
   - `BCCGModifyCardDrawInfluence`
   - You probably cant set x each turn begin without coding
2. Bolts deal +x damage:
   - (`BCCGModifyCardDamageInfluence`)
   - You probably cant set x each turn begin without coding

Its probably really complicated or not even possible.
So I think you have 2 choices:
1. Change your cards behavior to something simpler thats possible with existing influences or
2. Code your own influence