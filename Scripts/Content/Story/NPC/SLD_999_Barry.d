instance SLD_999_Barry(Npc_Default)
{
	// ------ NSC ------
	name 		= "Barry";
	guild 		= GIL_SLD;
	id 			= 999;
	voice 		= 13;
	flags       = 0;										//NPC_FLAG_IMMORTAL oder 0
	npctype		= NPCTYPE_MAIN;
	
	// ------ Attribute ------
	B_SetAttributesToChapter (self, 1);																	//setzt Attribute und LEVEL entsprechend dem angegebenen Kapitel (1-6)
		
	// ------ Kampf-Taktik ------
	fight_tactic		= FAI_HUMAN_NORMAL;	// MASTER / STRONG / NORMAL / COWARD
	
	// ------ Equippte Waffen ------																	//Munition wird automatisch generiert, darf aber angegeben werden
	EquipItem			(self, ItMw_1h_Sld_Axe);
	EquipItem			(self, ItRw_Sld_Bow);
	CreateInvItems 		(self, ItRw_Arrow, 10);
	
	// ------ Inventory ------
	B_CreateAmbientInv 	(self);
		
	// ------ visuals ------																			//Muss NACH Attributen kommen, weil in B_SetNpcVisual die Breite abh. v. STR skaliert wird
	B_SetNpcVisual 		(self, MALE, "Hum_Head_FatBald", Face_N_Drax, BodyTex_N, ITAR_Barry);		
	Mdl_SetModelFatness	(self, 0);
	Mdl_ApplyOverlayMds	(self, "Humans_Relaxed.mds"); // Tired / Militia / Mage / Arrogance / Relaxed
	
	// ------ NSC-relevante Talente vergeben ------
	B_GiveNpcTalents (self);
	
	// ------ Kampf-Talente ------																		//Der enthaltene B_AddFightSkill setzt Talent-Ani abh�ngig von TrefferChance% - alle Kampftalente werden gleichhoch gesetzt
	B_SetFightSkills (self, 30); //Grenzen f�r Talent-Level liegen bei 30 und 60

	// ------ TA anmelden ------
	daily_routine 		= Rtn_Start_999;
};

FUNC VOID Rtn_Start_999 ()
{
	TA_Stand_ArmsCrossed(07,00,21,00,"NW_CITY_MAINSTREET_07");
	TA_Stand_ArmsCrossed(21,00,07,00,"NW_CITY_MAINSTREET_07");
};

FUNC VOID Rtn_Guide_999 ()
{
	//TA_Guide_Player  (08,00,20,00,"NW_TAVERNE_OUT_01"); 
	//TA_Guide_Player	 (20,00,08,00,"NW_TAVERNE_OUT_01");
	TA_Guide_Player  (08,00,20,00,"NW_CITY_ENTRANCE_01"); 
	TA_Guide_Player	 (20,00,08,00,"NW_CITY_ENTRANCE_01");
};
