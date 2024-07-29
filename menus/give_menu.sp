char itemName[32];
//杂项类物品
public void BuildMiscItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("杂项");
	m.AddItem("gascan","汽油桶");
	m.AddItem("fireworkcrate","烟花盒");
	m.AddItem("propanetank","丙烷罐");
	m.AddItem("gnome","侏儒");
	m.AddItem("upgradepack_explosive","爆炸子弹升级包");
	m.AddItem("upgradepack_incendiary","燃烧子弹升级包");
	m.AddItem("oxygentank","氧气罐");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//近战类物品
public void BuildMeleeItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("近战");
	m.AddItem("chainsaw","电锯");
	m.AddItem("crowbar","撬棍");
	m.AddItem("fireaxe","消防斧");
	m.AddItem("katana","武士刀");
	m.AddItem("melee","匕首");
	m.AddItem("baseball_bat","棒球棍");
	m.AddItem("frying_pan","平底锅");
	m.AddItem("electric_guitar","吉他");
	m.AddItem("tonfa","警棍");
	m.AddItem("machete","砍刀");
	m.AddItem("cricket_bat","板球拍");
	m.AddItem("pitchfork","草叉");
	m.AddItem("shovel","铁楸");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//恢复类物品
public void BuildRestoreItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("药品");
	m.AddItem("first_aid_kit","医疗包");
	m.AddItem("defibrillator","起搏器");
	m.AddItem("pain_pills","止痛药");
	m.AddItem("adrenaline","肾上腺素注射器");
	m.AddItem("health","恢复血量");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//投掷物
public void BuildThrowingItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("投掷物");
	m.AddItem("pipe_bomb","土质炸弹");
	m.AddItem("molotov","莫洛托夫燃烧弹");
	m.AddItem("vomitjar","胆汁瓶");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//霰弹枪
public void BuildShotGunsItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("霰弹枪");
	m.AddItem("shotgun_chrome","铬合金霰弹枪");
	m.AddItem("pumpshotgun","泵动式霰弹枪");
	m.AddItem("shotgun_spas","SPAS-12霰弹枪");
	m.AddItem("autoshotgun","M1014霰弹枪");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//狙击步枪
public void BuildSniperItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("狙击步枪");
	m.AddItem("hunting_rifle","猎枪");
	m.AddItem("sniper_military","现代狙击步枪");
	m.AddItem("sniper_scout","鸟狙");
	m.AddItem("sniper_awp","AWP狙击步枪");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//构建步枪菜单
public void BuildRifleItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("步枪");
	m.AddItem("rifle_ak47","AK47突击步枪");
	m.AddItem("rifle","M16突击步枪");
	m.AddItem("rifle_desert","SCAR突击步枪");
	m.AddItem("rifle_sg552","SG552步枪");
	m.AddItem("rifle_m60","M60机枪");
	m.AddItem("grenade_launcher","M79榴弹发射器");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//构建冲锋枪菜单
public void BuildSMGItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("冲锋枪");
	m.AddItem("smg","冲锋枪");
	m.AddItem("smg_silenced","消音冲锋枪");
	m.AddItem("smg_mp5","MP5冲锋枪");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//构建手枪菜单
public void BuildPistolItemMenu(int client){
	Menu m=new Menu(GiveItemMenuHandler,MENU_ACTIONS_ALL);
	m.SetTitle("手枪");
	m.AddItem("pistol","手枪");
	m.AddItem("pistol_magnum","马格南手枪");
	m.ExitBackButton=true;
	m.Display(client,60);
}
//给予菜单
public void BuildGiveMenu(int client){
	Menu panel=new Menu(GiveMenuHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("给予物品");
	panel.AddItem("pistol","手枪");
	panel.AddItem("smg","冲锋枪");
	panel.AddItem("rifle","步枪/重型");
	panel.AddItem("sniper","狙击步枪");
	panel.AddItem("shotgun","霰弹枪");
	panel.AddItem("throw","投掷物");
	panel.AddItem("health","药品");
	panel.AddItem("melee","近战武器");
	panel.AddItem("misc","杂项");
	panel.ExitBackButton=true;
	panel.Display(client,60);
}
public int GiveMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:
				BuildPistolItemMenu(param1);
				case 1:
				BuildSMGItemMenu(param1);
				case 2:
				BuildRifleItemMenu(param1);
				case 3:
				BuildSniperItemMenu(param1);
				case 4:
				BuildShotGunsItemMenu(param1);
				case 5:
				BuildThrowingItemMenu(param1);
				case 6:
				BuildRestoreItemMenu(param1);
				case 7:
				BuildMeleeItemMenu(param1);
				case 8:
				BuildMiscItemMenu(param1);
			}
	}
	if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) ShowMainMenu(param1);
	}
	return 0;
}
//给予武器处理器
public int GiveItemMenuHandler(Menu menu, MenuAction action, int param1, int pos){
	if(action==MenuAction_Select){
		char item[32];
		menu.GetItem(pos,item,sizeof(item));
		PlayerSelectMenu(param1,SelectPlayerMenuHandler);
		itemName=item;
		}
	if(action==MenuAction_Cancel){
		if(pos==MenuCancel_ExitBack) BuildGiveMenu(param1);
	}
	return 0;
}
//玩家选择处理器
public int SelectPlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
			//给每个人添加一份
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			VS_GivePlayerItem(i,itemName);
			menu.Display(param1,60);
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
			//给自己
			VS_GivePlayerItem(param1,itemName);
			menu.Display(param1,60);
			return 0;
		}
		int index=StringToInt(playerIndex);
		VS_GivePlayerItem(index,itemName);
		menu.Display(param1,60);
		}
		if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) BuildGiveMenu(param1);
	}
	return 0;
}