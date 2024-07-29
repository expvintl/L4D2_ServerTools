public Action Command_Kill(int client,int args){
	if(GetClientTeam(client)==2) ForcePlayerSuicide(client);
	return Plugin_Handled;
}