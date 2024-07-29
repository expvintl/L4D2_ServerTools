public Action Command_DisableFF(int client, int args)
{
		if (args < 1)
		{
			ReplyToCommand(client, "用法: sm_ff [0/1]");
			return Plugin_Handled;
		}
		char value[4];
		GetCmdArg(1, value, sizeof(value));
		char cvars[][]={"survivor_friendly_fire_factor_easy","survivor_friendly_fire_factor_normal","survivor_friendly_fire_factor_hard","survivor_friendly_fire_factor_expert"};
		char values[][]={"0","0.1","0.3","0.5"};
		if(StrEqual(value, "1")){
		for(int i=0;i<4;i++){
		ConVar v = FindConVar(cvars[i]);
		v.SetString(values[i], true);
		}
		ReplyToCommand(client, "Enabled FF!");
		}else{
		for(int i=0;i<4;i++){
		ConVar v = FindConVar(cvars[i]);
		v.SetString("0", true);
		}
		ReplyToCommand(client, "Disabled FF!");
		}
		return Plugin_Handled;
}