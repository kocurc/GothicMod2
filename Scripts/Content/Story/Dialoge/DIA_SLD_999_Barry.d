//*********************************************************************
//	Info EXIT 
//*********************************************************************
INSTANCE DIA_Barry_EXIT(C_INFO)
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
INSTANCE DIA_Barry_Hello(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 4;
	condition   = DIA_Barry_Hello_Condition;
	information = DIA_Barry_Hello_Info;
	permanent   = FALSE;
	description = "Jak się masz?";
};

FUNC INT DIA_Barry_Hello_Condition()
{
	if (Npc_KnowsInfo(other, "DIA_Pablo_WANTED"))
	{
		return TRUE;
	};
};

FUNC VOID DIA_Barry_Hello_Info()
{
	AI_Output (other, self, "DIA_Barry_Hello_15_00"); //Co słychać?
	AI_Output (self, other, "DIA_Barry_Hello_55_01"); //Potrzebuję wody lub mleka. Suszy mnie...

	Log_CreateTopic(TOPIC_BarryDrink, LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BarryDrink, LOG_RUNNING);
	B_LogEntry(TOPIC_BarryDrink, "Barry potrzebuje uzupełnić elektrolity. Przyniosę mu wodę lub mleko");
};

//*********************************************************************
//	Info Completed
//*********************************************************************
INSTANCE DIA_SLD_999_Barry_Completed(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 4;
	condition   = DIA_SLD_999_Barry_Completed_Condition;
	information = DIA_SLD_999_Barry_Completed_Info;
	permanent   = FALSE;
	description = "Mam napój";
};

FUNC INT DIA_SLD_999_Barry_Completed_Condition()
{
	if (Npc_KnowsInfo(other, "DIA_Barry_Hello"))
		&& ((Npc_HasItems(other, ItFo_Milk) >= 1) || (Npc_HasItems(other, ItFo_Water) >= 1))
	{
		return TRUE;
	};
};

FUNC VOID DIA_SLD_999_Barry_Completed_Info()
{
	AI_Output (other, self, "DIA_SLD_999_Barry_Completed_15_00"); //Przyniosłem Ci napój
	AI_Output (self, other, "DIA_SLD_999_Barry_Completed_55_01"); //Oh dzięki!

	if (Npc_HasItems(other, ItFo_Milk) >= 1)
	{
		B_GiveInvItems(other, self, ItFo_Milk, 1);
	}
	else
	{
		B_GiveInvItems(other, self, ItFo_Water, 1);
	};

	// Zmiana gildii na naszą
	// Droga do tawerny

	B_LogEntry(TOPIC_BarryDrink, "Dałem Barry'emu napój");
	Log_SetTopicStatus(TOPIC_BarryDrink, LOG_SUCCESS);

	AI_Output (self, other, "DIA_SLD_999_Barry_Completed_55_01"); //Chodź jeszcze ze mną do tawerny!
	
};
