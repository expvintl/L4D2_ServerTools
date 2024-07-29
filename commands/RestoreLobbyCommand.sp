public Action Command_RestoreLobby(int client,int args){
    FindConVar("sv_allow_lobby_connect_only").SetBool(true);
    PrintToChat(client,"已恢复大厅!");
	return Plugin_Handled;
}