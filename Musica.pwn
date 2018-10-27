/*
	__             _    ___ ____           __          __ __
   / /_  __  __   | |  / (_) __ \____ _   / /   ____  / //_/___ _
  / __ \/ / / /   | | / / / / / / __ `/  / /   / __ \/ ,< / __ `/
 / /_/ / /_/ /    | |/ / / /_/ / /_/ /  / /___/ /_/ / /| / /_/ /
/_.___/\__, /     |___/_/_____/\__,_/  /_____/\____/_/ |_\__,_/
	  /____/

Não Retire os Créditos!!!
*/

#include <a_samp> //by SA-MP Team
#include <Pawn.CMD> //by UrShadow
//Também compatível com ZCMD
//#include <zcmd> //by Zeex

#define VERSAO "v1.1"

#define minutos(%0)	(1000 * %0 * 60)

#define V   "{FF0000}"
#define B   "{FFFFFF}"
#define A   "{0000FF}"

enum
{
	D_TIPOMUSICA = 22000,//Veja se não há outras dialogs com o mesmo id em seus FS/GM se tiver mude!
	D_MUSICADIR,
	D_MUSICANOME,
	D_MUSICAYTB,
	D_AJUDA,
	D_PEDIRMUSICA
};

enum Player_Data
{
	Nick[MAX_PLAYER_NAME]
};
new Player_Info[MAX_PLAYERS][Player_Data];

static bool: PediuMusica[MAX_PLAYERS char];

public OnFilterScriptInit()
{
	print("\n   [FS] Música "VERSAO" carregado by ViDa_LoKa");
	print("        Não Retire os Créditos!!!       \n");
	return true;
}

public OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, Player_Info[playerid][Nick], MAX_PLAYER_NAME);
	PediuMusica{playerid} = false;
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case D_TIPOMUSICA:
		{
			if !response *then
			{
				SendClientMessage(playerid, -1, ""A"DICA: "B"Comandos do Sistema de Música: "V"( /amusica )");
			}
			else
			{
				switch(listitem)
				{
					case 0: ShowPlayerDialog(playerid, D_MUSICADIR, DIALOG_STYLE_INPUT, "Música para todos", ""B"Insira o link direto da Música desejada!\n"A"[AVISO]: "B"Funcional apenas para o link de download da Música\n", "Tocar", "Fechar");
					case 1: ShowPlayerDialog(playerid, D_MUSICANOME, DIALOG_STYLE_INPUT, "Música para todos", ""B"Insira o nome da Música desejada!\n"A"[AVISO]: "B"Coloque o cantor e o nome da Música ou o link do youtube para melhores resultados\n", "Tocar", "Fechar");
					case 2: ShowPlayerDialog(playerid, D_MUSICAYTB, DIALOG_STYLE_INPUT, "Música para todos", ""B"Insira o id do youtube da Música desejada!\n"A"[EXEMPLO]: "B"https://www.youtube.com/watch?v="V"GbI7QLCpO70 "B"nesse link o ID é este: "V"\"GbI7QLCpO70\"\n", "Tocar", "Fechar");
				}
			}
		}
		case D_MUSICADIR:
		{
			if !response *then
			{
				SendClientMessage(playerid, -1, ""A"DICA: "B"Comandos do Sistema de Música: "V"( /amusica )");
			}
			else
			{
				if strlen(inputtext) < 1 *then
				{
					SendClientMessage(playerid, -1, ""V"ERRO: "B"Insira alguma Música!");
					ShowPlayerDialog(playerid, D_MUSICADIR, DIALOG_STYLE_INPUT, "Música para todos", ""B"Insira o link direto da Música desejada!\n"A"[AVISO]: "B"Funcional apenas para link de stream (link de download) da Música\n", "Tocar", "Fechar");
				}
				else
				{
					static str[128], str2[104];

					for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
					{
						format(str, sizeof(str), "%s", inputtext);
						PlayAudioStreamForPlayer(i, str);
						format(str2, sizeof(str2), ""A"[ADMIN] "V"%s "B"colocou uma Música, digite /pmusica se quiser parar!", Player_Info[playerid][Nick]);
					}
					SendClientMessageToAll(-1, str2);
				}
			}
		}

		case D_MUSICANOME:
		{
			if !response *then
			{
				SendClientMessage(playerid, -1, ""A"DICA: "B"Comandos do Sistema de Música: "V"( /amusica )");
			}
			else
			{
				if strlen(inputtext) < 1 *then
				{
					SendClientMessage(playerid, -1, ""V"ERRO: "B"Insira alguma Música!");
					ShowPlayerDialog(playerid, D_MUSICAYTB, DIALOG_STYLE_INPUT, "Música para todos", ""B"Insira o id do youtube da Música desejada!\n"A"[EXEMPLO]: "B"https://www.youtube.com/watch?v="V"GbI7QLCpO70 "B"nesse link o ID é este: "V"\"GbI7QLCpO70\"\n", "Tocar", "Fechar");
				}
				else
				{
					static str[128], str2[104];

					for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
					{
						format(str, sizeof(str), "https://up-m.ga/?cancion=%s", inputtext);
						PlayAudioStreamForPlayer(i, str);
						format(str2, sizeof(str2), ""A"[ADMIN] "V"%s "B"colocou a Música "V"%s, "B"digite /pmusica se quiser parar!", Player_Info[playerid][Nick], inputtext);
					}
					SendClientMessageToAll(-1, str2);
				}
			}
		}

		case D_MUSICAYTB:
		{
			if !response *then
			{
				SendClientMessage(playerid, -1, ""A"DICA: "B"Comandos do Sistema de Música: "V"( /amusica )");
			}
			else
			{
				if strlen(inputtext) < 1 *then
				{
					SendClientMessage(playerid, -1, ""V"ERRO: "B"Insira alguma Música!");
					ShowPlayerDialog(playerid, D_MUSICANOME, DIALOG_STYLE_INPUT, "Música para todos", "Insira o nome da Música desejada!\n(AVISO): Coloque o cantor e o nome da Música ou o link do youtube para melhores resultados\n", "Tocar", "Cancelar");
				}
				else
				{
					static str[128], str2[104];

					for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
					{
						format(str, sizeof(str), "http://ultramendoza-mp3.herokuapp.com/download?v=%s", inputtext);
						PlayAudioStreamForPlayer(i, str);
						format(str2, sizeof(str2), ""A"[ADMIN] "V"%s "B"colocou uma Música, "B"digite /pmusica se quiser parar!", Player_Info[playerid][Nick]);
					}
					SendClientMessageToAll(-1, str2);
				}
			}
		}

		case D_PEDIRMUSICA:
		{
			if !response *then
			{
				SendClientMessage(playerid, -1, ""A"DICA: "B"Comandos do Sistema de Música: "V"( /amusica )");
			}
			else
			{
				if strlen(inputtext) < 1 *then
				{
					SendClientMessage(playerid, -1, ""V"ERRO: "B"Insira alguma Música!");
					ShowPlayerDialog(playerid, D_PEDIRMUSICA, DIALOG_STYLE_INPUT, "Pedir uma Música", "Insira o nome da Música desejada!\n[AVISO]: Coloque o cantor e o nome da Música ou o link do youtube para melhores resultados\n", "Pedir", "Cancelar");
				}
				else
				{
					SendClientMessage(playerid, -1, ""A"AVISO: "B"Música enviada com sucesso aos "A"ADMINS!");
					PediuMusica{playerid} = true;
					SetTimerEx("ResetarPedidoDeMusica", minutos(2), false, "d", playerid);
					static str2[104];

					for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
					{
						if IsPlayerAdmin(i) *then
						{
							format(str2, sizeof(str2), ""A"ATENÇÃO ADMINS: "V"%s "B"está pedindo a Música "A"%s", Player_Info[playerid][Nick], inputtext);
							SendClientMessage(i, -1, str2);
						}
					}
				}
			}
		}
	}
	return false;
}

forward ResetarPedidoDeMusica(playerid);
public ResetarPedidoDeMusica(playerid)
{
	PediuMusica{playerid} = false;
	return true;
}
//Comandos
CMD:tocarmusica(playerid, params[])
{
	if !IsPlayerAdmin(playerid) *then
	return SendClientMessage(playerid, -1, ""V"ERRO: "B"Comando disponível apenas para admins RCON!");

	ShowPlayerDialog(playerid, D_TIPOMUSICA, DIALOG_STYLE_LIST, "Tipo de Música", "Música pelo link direto\nMúsica pelo nome\nMúsica pelo link do Youtube", "Ok", "Fechar");
	return true;
}

CMD:pmusicatodos(playerid, params[])
{
	if !IsPlayerAdmin(playerid) *then
	return SendClientMessage(playerid, -1, ""V"ERRO: "B"Comando disponível apenas para admins RCON!");

	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if IsPlayerConnected(i) *then
		{
			StopAudioStreamForPlayer(i);
		}
	}
	static str[128];
	format(str, sizeof(str), "[ADMIN] %s parou a Música atual!", Player_Info[playerid][Nick]);
	SendClientMessageToAll(-1, str);
	return true;
}

CMD:pmusica(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	SendClientMessage(playerid, -1, ""A"INFO: "B"A reprodução de sons foi parada!");
	return true;
}

CMD:pedirmusica(playerid, params[])
{
	if !PediuMusica{playerid} *then
	{
		ShowPlayerDialog(playerid, D_PEDIRMUSICA, DIALOG_STYLE_INPUT, "Pedir uma Música", "Insira o nome da Música desejada!\n[AVISO]: Coloque o cantor e o nome da Música ou o link do youtube para melhores resultados\n", "Pedir", "Cancelar");
	}
	else
	{
		SendClientMessage(playerid, -1, ""V"ERRO: "B"Aguarde 2 Minutos para pedir outra Música!");
	}
	return true;
}

CMD:amusica(playerid, params[])
{
	if !IsPlayerAdmin(playerid) *then
	{
		ShowPlayerDialog(playerid, D_AJUDA, DIALOG_STYLE_MSGBOX, "Comandos de Música", "/pmusica - Para a Música atual\n/pedirmusica - Envia a Música desejada para os admins online\n", "Ok", "");
	}
	else
	{
		ShowPlayerDialog(playerid, D_AJUDA, DIALOG_STYLE_MSGBOX, "Comandos de Música", "COMANDOS ADM: \n\n/tocarmusica - Toca uma Música para todos pelo nome ou link do youtube\n/pmusicatodos - Para a Música de todos\n\nCOMANDOS PLAYER: \n\n/pmusica - Para a Música atual\n/pedirmusica - Envia a Música desejada para os admins online\n", "Ok", "");
	}
	return true;
}
