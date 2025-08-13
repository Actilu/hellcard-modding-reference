## Common questions or mistakes

### Folder and file location

You have to create the folders yourself. You have to create a folder for each manager like `cards` or `monsters` if you need them. You also have to add the `languages` folder to the same location. The `language` folder will not show in the modding tool.
- My HELLCARD_Modding.exe is here: `D:\SteamLibrary\steamapps\common\HELLCARD\HELLCARD_Modding.exe`
- My cards folder is here: `D:\SteamLibrary\steamapps\common\HELLCARD\ccg_mod\cards`
- My language folder is here: `D:\SteamLibrary\steamapps\common\HELLCARD\ccg_mod\languages`
- And my lang files are inside the languages folder: `D:\SteamLibrary\steamapps\common\HELLCARD\ccg_mod\languages\en.utf8`

### File type

Language files should be a `.utf8` file. Check your file properties.

<img width="363" height="509" alt="grafik" src="https://github.com/user-attachments/assets/05763e1e-5217-42ed-a01a-95762fc7679b" />

### Case sensitivity

The `language keys` are case sensitive. 
1. So you either have to change the `lang key` in the en.utf8 file to `Bat_Strike_title`, or
2. You have to change the `UTFPrefix` in the editor to `bat_strike`.

---
