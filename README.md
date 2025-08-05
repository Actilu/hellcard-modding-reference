# Hellcard Modding References
A collection of Hellcard modding references.

Have a look at the official [Hellcard Mod Support Github](https://github.com/ThingTrunkOfficial/hellcard-mod-support).

[For more references look at the Wiki](https://github.com/LudgerHennersdorf/hellcard-modding-reference/wiki).

## AngelScript Influences
### Influence 001: character_influence_master.as
  - This influence should be added to a character `starter` artifact as `BCCGInfluencePushBehaviour`.
  - It will be invisible and controls other influences and interactions with specific cards.

  - Functionality:
  - When the player plays a card with `cardTag` tag, it pushes an influence with the tag `influenceTag` and the name `influenceName`.
    - Amount pushed is based on card-channel-parameter `cardParam`.
  - When a monster with the family name `monsterFamily` is killed, it pushes an influence with the tag `influenceTag` and the name `influenceName`.
    - Amount pushed is based on `stacksOnKill` variable.

  - You can enable debug messages by setting `debugMode` to true.
