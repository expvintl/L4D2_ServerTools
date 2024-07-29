bool IsSpawnPhysicsProp[32];
bool IsSelfModel[32];
public void MiscPropMenu(int client){
	Menu panel=new Menu(SpawnPropMenuHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("道具生成");
    panel.AddItem("avtaers","生还者");
    panel.AddItem("special","特感");
    panel.AddItem("vehicles","载具/飞机");
    panel.AddItem("moneny","讨口子组合");
    panel.AddItem("misc","杂项");
	panel.Display(client,60);
}
public int SpawnPropMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
        switch(param2){
            case 0:
            Avaters(param1);
            case 1:
            Special(param1);
            case 2:
            Vehicles(param1);
            case 3:
            MonenyProp(param1);
            case 4:
            MiscProp(param1);
        }
    }
	return 0;
}
public void MonenyProp(int client){
    Menu panel=new Menu(SpawnPropOptionHandler,MENU_ACTIONS_ALL);
    panel.SetTitle("道具生成");
	panel.AddItem("models/props_collectables/piepan.mdl","碗");
    panel.AddItem("models/props_collectables/money_wad.mdl","一叠美钞");
    panel.AddItem("models/props_collectables/coin.mdl","金币");
    panel.AddItem("models/props_collectables/mushrooms.mdl","小蘑菇");
    panel.AddItem("models/props_collectables/vault.mdl","金库");
    panel.AddItem("models/props_collectables/gold_bar.mdl","金条");
    panel.AddItem("models/props_collectables/flower.mdl","小草");
    panel.AddItem("models/props_collectables/backpack.mdl","行囊");
    panel.AddItem("models/props_collectables/alchemy_table.mdl","小烧杯");
    
	panel.Display(client,60);
}
public void MiscProp(int client){
    Menu panel=new Menu(SpawnPropOptionHandler,MENU_ACTIONS_ALL);
    panel.SetTitle("道具生成");
	panel.AddItem("models/items/l4d_gift.mdl","L4D礼盒");
    panel.AddItem("models/props_crates/static_crate_40.mdl","木板箱");
    panel.AddItem("models/props_mining/elevator01_cage.mdl","电梯");
    panel.AddItem("models/props_misc/gazebo.mdl","遮阳篷");
    panel.AddItem("models/props_equipment/gas_pump_nodebris.mdl","加油机");
    panel.AddItem("models/props_fairgrounds/gallery_target_skeleton.mdl","骷髅牌子")
    panel.AddItem("models/infected/common_male_ceda.mdl","CEDA");
    panel.AddItem("models/npcs/rescue_pilot_01.mdl","机长");
    panel.AddItem("models/props_doors/checkpoint_door_02.mdl","安全门");
	panel.Display(client,60);
}
public void Vehicles(int client){
	Menu panel=new Menu(SpawnPropOptionHandler,MENU_ACTIONS_ALL);
    panel.SetTitle("道具生成");
	panel.AddItem("models/c2m5_helicopter_extraction/c2m5_helicopter_small.mdl","小飞机");
    panel.AddItem("models/props_vehicles/army_truck.mdl","军用货车");
    panel.AddItem("models/props_vehicles/ambulance.mdl","救护车");
    panel.AddItem("models/props_vehicles/helicopter_rescue.mdl","救援直升机");
    panel.AddItem("models/props_vehicles/boat_rescue_tug.mdl","救援船只");
    panel.AddItem("models/props_vehicles/helicopter_rescue_smashed.mdl","坠毁直升机");
    panel.AddItem("models/props_vehicles/helicopter_news_downed.mdl","坠毁新闻直升机");
	panel.Display(client,60);
}
public void Avaters(int client){
    Menu panel=new Menu(SpawnPropOptionHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("道具生成");
    panel.AddItem("models/survivors/survivor_coach.mdl","教练");
    panel.AddItem("models/survivors/survivor_gambler.mdl","尼克");
    panel.AddItem("models/survivors/survivor_mechanic.mdl","Eills");
    panel.AddItem("models/survivors/survivor_producer.mdl","罗谢尔");
    panel.AddItem("models/survivors/survivor_teenangst.mdl","佐伊");
    panel.AddItem("models/survivors/survivor_namvet.mdl","比尔");
    panel.AddItem("models/survivors/survivor_biker.mdl","弗朗西斯");
    panel.AddItem("models/survivors/survivor_manager.mdl","路易斯");
    panel.Display(client,60);
}
public void Special(int client){
     Menu panel=new Menu(SpawnPropOptionHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("道具生成");
    panel.AddItem("models/infected/smoker.mdl","Smoker");
    panel.AddItem("models/infected/boomer.mdl","Boomer");
    panel.AddItem("models/infected/hunter.mdl","猎人");
    panel.AddItem("models/infected/spitter.mdl","Spitter");
    panel.AddItem("models/infected/jockey.mdl","Jockey");
    panel.AddItem("models/infected/charger.mdl","Charger");
    panel.AddItem("models/infected/witch.mdl","Witch");
    panel.AddItem("models/infected/witch_bride.mdl","Witch Bride");
    panel.AddItem("models/infected/hulk.mdl","Tank");
    panel.AddItem("models/infected/hulk_dlc3.mdl","Tank2");
    panel.AddItem("models/infected/hulk_l4d1.mdl","Tank L4D1");
    panel.Display(client,60);
}
public int SpawnPropOptionHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
        char prop[64];
		menu.GetItem(param2,prop,sizeof(prop));
        if(IsSelfModel[param1]){
            ChangePlayerModel(param1,prop);
        }else{
	    	SpawnPropInAim(param1,prop,IsSpawnPhysicsProp[param1]);           
        }
                menu.Display(param1,60);
    }
	return 0;
}