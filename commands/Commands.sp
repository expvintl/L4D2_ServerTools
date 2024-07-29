#include "commands/KillCommand.sp"
#include "commands/StatusCommand.sp"
#include "commands/BanCommand.sp"
#include "commands/KickCommand.sp"
#include "commands/DisableFFCommand.sp"
#include "commands/CvarCommand.sp"
#include "commands/DropCommand.sp"
#include "commands/ForceNameCommand.sp"
#include "commands/RemoveLobbyCommand.sp"
#include "commands/RestoreLobbyCommand.sp"
#include "ForceSayCommand.sp"
#include "ForceTeamCommand.sp"
public void RegisterCommands(){
    RegAdminCmd("sm_cvar", Command_Cvar, ADMFLAG_GENERIC, "sm_cvar <cvar> [value]");
	RegAdminCmd("sm_ff", Command_DisableFF, ADMFLAG_GENERIC, "sm_ff [0/1]");
	RegConsoleCmd("sm_kill",Command_Kill,"杀死你自己");
	RegConsoleCmd("sm_zs",Command_Kill,"杀死你自己");
	RegAdminCmd("sm_kick",Command_Kick,ADMFLAG_GENERIC,"sm_kick [player]");
	RegAdminCmd("sm_ban",Command_Ban,ADMFLAG_GENERIC,"sm_ban [player]");
	RegConsoleCmd("sm_tools",Command_Tools,"open menu");
	RegConsoleCmd("status",Command_Status,"status");
	RegConsoleCmd("sm_drop",Command_DropWeapon,"Drop Your Weapon!!");
	RegConsoleCmd("sm_forcename",Command_ForceName,"Force Name!");
	RegAdminCmd("sm_lobby",Command_RemoveLobby,ADMFLAG_GENERIC,"Remove Lobby");
	RegAdminCmd("sm_relobby",Command_RestoreLobby,ADMFLAG_GENERIC,"Restore Lobby");
	RegConsoleCmd("sm_say",Command_ForceSay,"Force Say!");
	RegConsoleCmd("sm_forceteam",Command_ForceTeam,"ForceTeam!!");
}