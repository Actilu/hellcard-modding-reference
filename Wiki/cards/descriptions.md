Information on [Language file content is also available on Github](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/Languages.md#language-files-content).
- `\1` to `\8`: display the values from the specific card channel `P0` to `P7`
  - `\1` is Damage
  - `\2` is Block
  - and so on
- `\^[hex value]\<TEXT>\^^` is used to color specific text sections
  - cards use `[hex value]` = `debf56` to highlight keywords like Exhaust and Block.
  - lokks like this: `\^debf56Stamina\^^`
Information on creating cards and [how to display keywords is also available on Github](https://github.com/ThingTrunkOfficial/hellcard-mod-support/blob/main/docs/CreatingNewCard.md#adding-new-cards).
- Keywords: you can add keywords to this list to display them in the tooltip. [Available keywords](https://github.com/LudgerHennersdorf/hellcard-modding-reference/wiki/Keywords).
- Tags: here you can add tags for functionality but also for displaying cards in the tooltip
  - add the name of another card here to show it in the tooltip: e.g. `car_001_war`