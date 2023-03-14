//*********************************************************************
//	Info EXIT 
//*********************************************************************
INSTANCE DIA_Barry_EXIT   (C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 999;
	condition   = DIA_Barry_EXIT_Condition;
	information = DIA_Barry_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Barry_EXIT_Condition()
{
	return TRUE;
};

FUNC VOID DIA_Barry_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

//*********************************************************************
//	Info Hello 
//*********************************************************************
INSTANCE DIA_Barry_Hello		(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 4;
	condition   = DIA_Barry_Hello_Condition;
	information = DIA_Barry_Hello_Info;
	permanent   = FALSE;
	description = "Jak sie masz";
};

FUNC INT DIA_Barry_Hello_Condition()
{
	if Npc_KnowsInfo(other, DIA_Pablo_Banditen) || Npc_KnowsInfo(other, DIA_Pablo_Perm)
	{
		return TRUE;
	};
};

FUNC VOID DIA_Barry_Hello_Info()
{
	AI_Output (other, self, "DIA_Barry_Hello_15_00"); //Co slychac?
	AI_Output (self, other, "DIA_Barry_Hello_55_01"); //Potrzebuje wody lub mleka. Suszy mnie...

	Log_CreateTopic(TOPIC_BarryDrink, LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BarryDrink, LOG_RUNNING);
	B_LogEntry(TOPIC_BarryDrink, "Barry potrzebuje uzupelnic elektrolity. Przyniose mu wode lub mleko");
};

//*********************************************************************
//	Info Completed
//*********************************************************************
INSTANCE DIA_Barry_Completed		(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 4;
	condition   = DIA_Barry_Completed_Condition;
	information = DIA_Barry_Completed_Info;
	permanent   = FALSE;
	description = "Mam napoj";
};

FUNC INT DIA_Barry_Completed_Condition()
{
	if Npc_KnowsInfo(other, DIA_Barry_Hello)
		&& ((Npc_HasItems(other, ItFo_Milk) >= 1) || (Npc_HasItems(other, ItFo_Water) >= 1))
	{
		return TRUE;
	};
};

FUNC VOID DIA_Barry_Completed_Info()
{
	AI_Output (other, self, "DIA_Barry_Completed_15_00"); //Przynioslem Ci napoj
	AI_Output (self, other, "DIA_Barry_Completed_55_01"); //Oh dzieki! Ale chodz ze mna jeszcze do tawerny

	if (Npc_HasItems(other, ItFo_Milk) >= 1)
	{
		B_GiveInvItems(other, self, ItFo_Milk, 1);
	}
	else
	{
		B_GiveInvItems(other, self, ItFo_Water, 1);
	};

	Npc_SetTrueGuild (self, hero.guild);
	Npc_ExchangeRoutine (self, "Guide");
	B_LogEntry(TOPIC_BarryDrink, "Dalem Barry'emu napoj, a on mnie jeszcze ciagnie do tawerny. Co za czlowiek!");

	if Hlp_StrCmp(Npc_GetNearestWP(self), "NW_CITY_MAINSTREET_07")
	{
		AI_Output (self, other, "DIA_Barry_Completed_55_01"); //No jestesmy w koncu!
		B_LogEntry(TOPIC_BarryDrink, "Dotarlismy do celu");
	};

	Log_SetTopicStatus(TOPIC_BarryDrink, LOG_SUCCESS);
};
