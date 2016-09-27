/*
    __             _    ___ ____           __          __ __
   / /_  __  __   | |  / (_) __ \____ _   / /   ____  / //_/___ _
  / __ \/ / / /   | | / / / / / / __ `/  / /   / __ \/ ,< / __ `/
 / /_/ / /_/ /    | |/ / / /_/ / /_/ /  / /___/ /_/ / /| / /_/ /
/_.___/\__, /     |___/_/_____/\__,_/  /_____/\____/_/ |_\__,_/
      /____/

Não Retire os Créditos!!!
*/

#include a_samp //by Samp Team
#include zcmd //by Zeex

//Veja se não tem outras dialogs com o mesmo id em seus FS/GM se tiver mude!
#define D_MUSICA        1
#define D_AJUDA         2
#define D_PEDIRMUSICA   3

#define COR_ERRO        0xFF0000FF
#define COR_INFO        0x00FF00FF
#define COR_DICA        0x0000FFFF

new pname[MAX_PLAYER_NAME];
new bool:PediuMusica[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n   [FS] Música carregado by ViDa_LoKa   ");
	print("        Não Retire os Créditos!!!       \n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
public OnPlayerConnect(playerid)
{
	PediuMusica[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	static nomedoserver[64], str[128];
    GetConsoleVarAsString("hostname", nomedoserver, sizeof(nomedoserver));
    format(str, sizeof(str), "O %s contém um sistema de música feito por ViDa_Loka | CMD: /amusica ", nomedoserver);
	SendClientMessage(playerid, COR_DICA, str);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == D_MUSICA)
    {
        if(!response)
        {
            SendClientMessage(playerid, COR_INFO, "DICA: Comandos do Sistema de Música: ( /amusica )");
        }
        else
        {
            if(strlen(inputtext) < 1)
            {
				SendClientMessage(playerid, COR_ERRO, "ERRO: Insira alguma música!");
                ShowPlayerDialog(playerid, D_MUSICA, DIALOG_STYLE_INPUT, "Música para todos", "Insira o nome da música desejada!\n(AVISO): Coloque o cantor e o nome da música ou o link do youtube para melhores resultados\n", "Tocar", "Cancelar");
			}
            else
            {
			static i, str[128], str2[104+MAX_PLAYER_NAME];
			GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
			for( i = GetMaxPlayers() - 1; i > -1; --i)
			{
				if(IsPlayerConnected(i))
				{
				format(str, sizeof(str), "https://6t.pe/?song=%s", inputtext);
				PlayAudioStreamForPlayer(i, str);
				format(str2, sizeof(str2), "[ADMIN] %s colocou a música %s, digite /pmusica se quiser parar!", pname, inputtext);
				}
				}
 			SendClientMessageToAll(COR_INFO, str2);
            }
        }
        return 1;
    }
    if(dialogid == D_PEDIRMUSICA)
    {
        if(!response)
        {
            SendClientMessage(playerid, COR_DICA, "DICA: Comandos do Sistema de Música: ( /amusica )");
        }
        else
        {
            if(strlen(inputtext) < 1)
            {
				SendClientMessage(playerid, COR_ERRO, "ERRO: Insira alguma música!");
                ShowPlayerDialog(playerid, D_PEDIRMUSICA, DIALOG_STYLE_INPUT, "Pedir uma Música", "Insira o nome da música desejada!\n[AVISO]: Coloque o cantor e o nome da música ou o link do youtube para melhores resultados\n", "Pedir", "Cancelar");
			}
            else
            {
            SendClientMessage(playerid, COR_DICA, "AVISO: Música enviada com sucesso aos ADMINS!");
           	PediuMusica[playerid] = true;
			SetTimerEx("PedidoDeMusica", 120000, false, "d", playerid);
			static i, str2[104+MAX_PLAYER_NAME];
			GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
			for( i = GetMaxPlayers() - 1; i > -1; --i)
			{
				if(IsPlayerAdmin(i))
				{
				format(str2, sizeof(str2), "ATENÇÃO ADMINS: %s está pedindo a música %s", pname, inputtext);
				SendClientMessage(i, COR_INFO, str2);
				}
				}
            }
        }
        return 1;
    }
    return 1;
}
//Funções
forward PedidoDeMusica(playerid);
public PedidoDeMusica(playerid)
{
    PediuMusica[playerid] = false;
	return 1;
}
//Comandos
CMD:tocarmusica(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COR_ERRO, "ERRO: Comando disponível apenas para admins RCON!");
	ShowPlayerDialog(playerid, D_MUSICA, DIALOG_STYLE_INPUT, "Música para todos", "Insira o nome da música desejada!\n[AVISO]: Coloque o cantor e o nome da música ou o link do youtube para melhores resultados\n", "Tocar", "Cancelar");
	return 1;
}
CMD:pmusicatodos(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COR_ERRO, "ERRO: Comando disponível apenas para admins RCON!");
 	static i,str[104+MAX_PLAYER_NAME];
  	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	for( i = GetMaxPlayers() - 1; i > -1; --i)
	{
 	if(IsPlayerConnected(i))
 	{
	StopAudioStreamForPlayer(i);
	}
	}
	format(str, sizeof(str), "[ADMIN] %s parou a música atual!", pname);
	SendClientMessageToAll(COR_INFO, str);
	return 1;
}
CMD:pmusica(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	SendClientMessage(playerid, COR_INFO, "INFO: A reprodução de sons foi parada!");
	return 1;
}
CMD:pedirmusica(playerid, params[])
{
	if(PediuMusica[playerid] == false)
	{
	ShowPlayerDialog(playerid, D_PEDIRMUSICA, DIALOG_STYLE_INPUT, "Pedir uma Música", "Insira o nome da música desejada!\n[AVISO]: Coloque o cantor e o nome da música ou o link do youtube para melhores resultados\n", "Pedir", "Cancelar");
	}
	else
	{
	SendClientMessage(playerid, COR_ERRO, "ERRO: Aguarde 2 Minutos para pedir outra música!");
	}
	return 1;
}
CMD:amusica(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
	ShowPlayerDialog(playerid, D_AJUDA, DIALOG_STYLE_MSGBOX, "Comandos de Música", "COMANDOS ADM: \n\n/tocarmusica - Toca uma música para todos pelo nome ou link do youtube\n/pmusicatodos - Para a música de todos\n\nCOMANDOS PLAYER: \n\n/pmusica - Para a música atual\n/pedirmusica - Envia a música desejada para os admins online\n", "Ok", "");
	}
	else
	{
	ShowPlayerDialog(playerid, D_AJUDA, DIALOG_STYLE_MSGBOX, "Comandos de Música", "/pmusica - Para a música atual\n/pedirmusica - Envia a música desejada para os admins online\n", "Ok", "");
	}
	return 1;
}
#error "Não Retire os Créditos!!!"
