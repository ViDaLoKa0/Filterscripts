#include <a_samp>

#define COR_NICK 0xFF0000FF //COR DO NICK DO BOT

#define NOME_BOT OLA_SOU_UM_BOT //NOME DO BOT
#define ID 100 //ID DO BOT

//palavras que o bot irá detectar
new FalouHack[] =
{
	"hack",
	"hacke",
	"hackerzinho",
	"racker",
	"hacki",
	"hackerzin",
	"raki",
	"hask",
	"raker",
	"hak",
	"aim",
	"aimbot",
	"hacker",
	"xitado",
	"xiter",
	"haskudo"
};

public OnPlayerText(playerid, text[])
{
	if(strfind(text, FalouHack, true) != -1)
	{
		SetTimerEx("BotMensagem", 2000, false, "i", playerid);
	}
	return 1;
}

forward BotMensagem(playerid);
public BotMensagem(playerid)
{
	static str[128],pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str, sizeof (str), ""#NOME_BOT": {FFFFFF}[ID:"#ID"]: %s, use /report id motivo para reportar o hack!", pname);
	return SendClientMessageToAll(COR_NICK, str);
}
//BY ViDa_LoKa
