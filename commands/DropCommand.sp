public Action Command_DropWeapon(int client,int args){
	if(client==0||!IsClientInGame(client)||IsFakeClient(client)||GetClientTeam(client)!=2) return Plugin_Handled;
    VS_DropCurrentWeapon(client);
	return Plugin_Handled;
}