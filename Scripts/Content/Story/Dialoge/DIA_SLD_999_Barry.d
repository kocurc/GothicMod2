
//*********************************************************************
//	Info EXIT 
//*********************************************************************
INSTANCE DIA_DJG_715_Ferros_EXIT(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 999;
	condition   = DIA_SLD_999_Barry_EXIT_Condition;
	information = DIA_SLD_999_Barry_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_SLD_999_Barry_EXIT_Condition()
{
	return TRUE;
};

FUNC VOID DIA_SLD_999_Barry_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

//*********************************************************************
//	Info Hello 
//*********************************************************************
INSTANCE DIA_SLD_999_Barry_Hello(C_INFO)
{
	npc         = SLD_999_Barry;
	nr          = 4;
	condition   = DIA_SLD_999_Barry_Hello_Condition;
	information = DIA_SLD_999_Barry_Hello_Info;
	permanent   = FALSE;
	description = "Jak się masz?";
};

FUNC INT DIA_SLD_999_Barry_Hello_Condition()
{
	if (Npc_KnowsInfo(other, "DIA_Pablo_WANTED"))
	{
		return TRUE;
	};
};

FUNC VOID DIA_SLD_999_Barry_Hello_Info()
{
	AI_Output (other, self, "DIA_SLD_999_Barry_Hello_15_00"); //Co słychać?
	AI_Output (self, other, "DIA_SLD_999_Barry_Hello_55_01"); //Potrzebuję wody lub mleka. Suszy mnie...

};
