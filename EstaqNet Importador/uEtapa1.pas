unit uEtapa1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids, jpeg,
  DBCtrls, SUIDBCtrls, Mask, Gauges;

type
  TfrmEtapa1 = class(TForm)
    pgEtapas: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    OpenDialog1: TOpenDialog;
    btSelecionarMDB: TBitBtn;
    lblNomeMDB: TStaticText;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    btProvedor: TBitBtn;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblHost: TEdit;
    lblUser: TEdit;
    lblPassword: TEdit;
    lblSchema: TEdit;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    lblNomeMDB1: TStaticText;
    gradeObras: TDBGrid;
    pnAviso: TPanel;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    btEnviarSite: TBitBtn;
    Label14: TLabel;
    Label15: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBGrid2: TDBGrid;
    comboMaquinas: TDBLookupComboBox;
    Label17: TLabel;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    GroupBox5: TGroupBox;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    Memo1: TMemo;
    Gauge1: TGauge;
    Gauge2: TGauge;
    Memo2: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    btProximoEtapa1: TBitBtn;
    btProximoEtapa2: TBitBtn;
    btRetornar2: TBitBtn;
    btProximoEtapa3: TBitBtn;
    btRetornar3: TBitBtn;
    btRetornar4: TBitBtn;
    procedure btSelecionarMDBClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btProximoEtapa2Click(Sender: TObject);
    procedure btProvedorClick(Sender: TObject);
    procedure gradeObrasCellClick(Column: TColumn);
    procedure btProximoEtapa1Click(Sender: TObject);
    procedure btProximoEtapa3Click(Sender: TObject);
    procedure LancarProducao(           _idpatrimonio,
                                        _idobra,
                                        _idfechamento,
                                        _idservico,
                                        _sigla,
                                        _data_lcto,
                                        _estacaid,
                                        _diametro,
                                        _hora_inicio,
                                        _hora_termino,
                                        _profundidade,
                                        _concretagem_hora_inicio,
                                        _concretagem_hora_termino,
                                        _sobre_consumo,
                                        _importador_arquivo:string);
    procedure DBEdit1Change(Sender: TObject);

    procedure ExecutarSQL(wsql:string);

    procedure btEnviarSiteClick(Sender: TObject);
    procedure btEncerrarClick(Sender: TObject);
    procedure btRetornar4Click(Sender: TObject);
    procedure btRetornar3Click(Sender: TObject);
    procedure btRetornar2Click(Sender: TObject);


    function  consultarDiametro(wdiametro:real):string;
    function  consultarIdDiametro(wdiametro:real):string;
    function  consultarLctoArquivo():string;
    function  formatarRealString(wReal:real):string;
    function  formatarData(wData:string):string;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEtapa1: TfrmEtapa1;
  widobra:string;
implementation

uses uDM,Math ;
{$R *.dfm}

procedure TfrmEtapa1.btSelecionarMDBClick(Sender: TObject);
begin
 if ( opendialog1.Execute ) then
  begin


      lblNomeMDB.Caption:=opendialog1.FileName;
      btProximoEtapa2.Enabled:=true;
  end
 else
  begin
     lblNomeMDB.Caption:='';
  end
 ;
end;

procedure TfrmEtapa1.BitBtn1Click(Sender: TObject);
var
 strConn:string;
 strMsg:string;
 strMDB:string;
 strMDBDesejado:string;
 strOBRACodigo:string;
 strOBRAData:string;
 dt1,dt2,d,m,a:string;
 data: TDateTime;
begin
Try
 begin

   //Fazer checagem do nome do arquivo para um padrão...
   //strMDBDesejado='OB-00013_2020_27022020.MDB'
   //                         11111111112222222
   //                12345678901234567890122222
   strMDB:=trimRight(trimLeft(uppercase(lblNomeMDB1.Caption)));;

   strOBRACodigo:=stringreplace( uppercase(uDM.dm1.tabelaObrasobracodigo.AsString) , '/', '_', [rfReplaceAll, rfIgnoreCase]) ;
   strOBRACodigo:=stringreplace( strOBRACodigo , '-', '_', [rfReplaceAll, rfIgnoreCase]) ;

   strMDBDesejado:= uppercase(strOBRACodigo+'_'+formatdatetime('ddmmyyyy', Now)+'.MDB');
   strMDBDesejado:=stringreplace( strMDBDesejado , '-', '_', [rfReplaceAll, rfIgnoreCase]) ;



   //------------------------------------------------------------
   // Verificar se o começo do mdb bate com a código da obra
   //------------------------------------------------------------
   if ( copy( strMDB,1,13) <>  copy( strOBRACodigo,1,13) )   then
    begin
     MessageDlg(
                  'ERRO: INÍCIO DO NOME MDB , INVÁLIDO! '+#13+#10+#13+#10+
                  '-------------------------------------------------------'+#13+#10+#13+#10+
                  'O arquivo que você capturou '+strMDB+#13+#10+
                  'possui um início ('+ copy( strMDB,1,13)+') que NÃO bate com '+#13+#10+
                  'o desejado :'+ copy( strOBRACodigo,1,13) +#13+#10+#13+#10+#13+#10+#13+#10+
                  '-------------------------------------------------------'+#13+#10+
                  'EXEMPLO:CÓDIGO DA OBRA  DATA DA PRODUÇÃO'+#13+#10+
                  copy( strOBRACodigo,1,13) +'_DDMMAAAA.MDB '+#13+#10+#13+#10+
                  'Vide Abaixo:'+#13+#10+#13+#10+
                  '         '+ strMDBDesejado +#13+#10+
                  '-------------------------------------------------------'+#13+#10+#13+#10+#13+#10+#13+#10+
                  'Renomeie o arquivo e tente novamente...'

                  ,mtError,[mbOk],0);
     exit;
    end;


   //------------------------------------------------------------
   // Verificar se a data esta correta
   //------------------------------------------------------------
   dt1:= copy(strMDB,15,8) ;
   //31032020
   //12345678

   d:=  copy(dt1,1,2);
   m:=  copy(dt1,3,2);
   a:=  copy(dt1,5,4);
   dt2:=d+'/'+m+'/'+a;

   strOBRAData:=dt2;
   if (TryStrToDate(strOBRAData,data)) then
    begin
     //showmessage(   strOBRAData+ ' ok!' );
    end
   else
    begin
     MessageDlg(
                  'ERRO: INÍCIO DO NOME MDB , INVÁLIDO! '+#13+#10+#13+#10+
                  '-------------------------------------------------------'+#13+#10+#13+#10+
                  'O arquivo que você capturou '+strMDB+#13+#10+
                  'possui uma data inválida ('+ dt1 +') no nome do arquivo '+#13+#10+
                  '-------------------------------------------------------'+#13+#10+
                  'EXEMPLO:CÓDIGO DA OBRA  DATA DA PRODUÇÃO'+#13+#10+
                  copy( strOBRACodigo,1,13) +'_DDMMAAAA.MDB '+#13+#10+#13+#10+
                  'Vide Abaixo:'+#13+#10+#13+#10+
                  '         '+ strMDBDesejado +#13+#10+
                  '-------------------------------------------------------'+#13+#10+#13+#10+#13+#10+#13+#10+
                  'Renomeie o arquivo e tente novamente...'

                  ,mtError,[mbOk],0);
     exit;
    end
   ;

   uDM.dm1.ADOConnection1.Connected:=false;
   strConn:='DBQ='+strMDB+';Driver={Driver do Microsoft Access (*.mdb)};DriverId=25;FIL=MS Access;';
   uDM.dm1.ADOConnection1.ConnectionString:=strConn;
   uDM.dm1.ADOConnection1.Connected:=true;
   uDM.dm1.tabelaEstaca.Active:=true;
   uDM.dm1.tabelaEstacaDiametros.Active:=true;
   btProximoEtapa3.Enabled:=true;
 end
Except
  on E: Exception do
    begin
     strMsg:='Erro ao tentar abrir o arquivo MDB' + #13#10 + #13#10 + E.Message;
     ShowMessage( strMsg );
    end;
   end;

end;

procedure TfrmEtapa1.FormCreate(Sender: TObject);
begin
 btProximoEtapa1.Enabled:=false;
 btProximoEtapa2.Enabled:=false;
 btProximoEtapa3.Enabled:=false;


 gradeObras.Visible:=false;
 pnAviso.Visible:=false;

 pgEtapas.Pages[0].TabVisible:=true;
 pgEtapas.Pages[1].TabVisible:=false;
 pgEtapas.Pages[2].TabVisible:=false;
 pgEtapas.Pages[3].TabVisible:=false;
 pgEtapas.ActivePageIndex:=0;
end;

procedure TfrmEtapa1.btProximoEtapa2Click(Sender: TObject);
var
 strMDB,strExtension:string;
begin

 strMDB:=trimRight(trimLeft(lblNomeMDB.Caption));;
 if (strMDB='') then
  begin
   showmessage('Selecione o arquivo MDB');
  end
 else
  if fileExists(strMDB) then
   begin
    strExtension:=lowercase(ExtractFileExt(strMDB));
    if (strExtension='.mdb') then begin


     lblNomeMDB1.Caption:=lowercase(ExtractFileName(strMDB));


     pgEtapas.Pages[2].TabVisible:=true;
     pgEtapas.ActivePageIndex:=2;
    end;
   end
  else
   begin
    lblNomeMDB1.Caption:='';
    showmessage('Erro não encontrado: '+strMDB);
   end
  ;
 ;
end;

procedure TfrmEtapa1.btProvedorClick(Sender: TObject);
var
 strMsg:string;
begin
Try
 begin
  gradeObras.Visible:=false;
  pnAviso.Visible:=true;
  frmEtapa1.Repaint;

  uDM.dm1.ZConnection1.Connected:=false;

  uDM.dm1.ZConnection1.HostName:= trimRight(trimLeft(lblHost.Text));
  uDM.dm1.ZConnection1.User    := trimRight(trimLeft(lblUser.Text));
  uDM.dm1.ZConnection1.Password:= trimRight(trimLeft(lblPassword.Text));
  uDM.dm1.ZConnection1.Database:= trimRight(trimLeft(lblSchema.Text));


  uDM.dm1.ZConnection1.Properties.Values['codepage']:='UTF8';
  uDM.dm1.ZConnection1.Properties.Values['client_encoding']:='UTF8';

  uDM.dm1.ZConnection1.Connected:=true;

  uDM.dm1.tabelaObras.Open;
  uDM.dm1.tabelaMaquinas.Open;
  showmessage( 'De um clique na obra a receber os lançamentos...');
 end
Except
  on E: Exception do
    begin
     strMsg:='Erro ao tentar abrir o arquivo MDB' + #13#10 + #13#10 + E.Message;
     ShowMessage( strMsg );
    end;
   end;

end;

procedure TfrmEtapa1.gradeObrasCellClick(Column: TColumn);
begin
 widobra:=uDM.dm1.tabelaObras.FieldByName('idobra').AsString;
end;

procedure TfrmEtapa1.btProximoEtapa1Click(Sender: TObject);
var
 widproposta,wDescObra:string;
begin
 widobra:=trimright(trimleft(uDM.dm1.tabelaObrasidobra.AsString));
 widproposta:=trimright(trimleft(uDM.dm1.tabelaObrasidproposta.AsString));
 //showmessage( widobra );
 if (widobra='') then begin
   showmessage( 'Clique na obra a transferir os dados' );
   exit;
 end;

 wDescObra:='--------------------------------------------------------------------'+#13+#10+
            'Obra :'+uDM.dm1.tabelaObrasobracodigo.AsString+'     Proposta :'+uDM.dm1.tabelaObraspropostacodigo.AsString+#13+#10+
            '--------------------------------------------------------------------'+#13+#10+
            'Cliente  :'+uDM.dm1.tabelaObrasrazao.AsString+#13+#10+
            'Endereço :'+uDM.dm1.tabelaObrasendereco.AsString+#13+#10+
            'Empreendimento :'+uDM.dm1.tabelaObrasdestinacao.AsString+#13+#10+
            'Destinação :'+uDM.dm1.tabelaObrasdestinacao.AsString+#13+#10+
            '--------------------------------------------------------------------';
 If  MessageDlg('Confirma a obra?'+#13+#10+wDescObra,mtConfirmation,[mbyes,mbno],0)=mrno then exit;

 pgEtapas.Pages[1].TabVisible:=true;
 pgEtapas.ActivePageIndex:=1;
end;

procedure TfrmEtapa1.btProximoEtapa3Click(Sender: TObject);
var
 wDiametroMDB:real;
 wArquivoValido:boolean;
 wDiametroCadastradoSN:string;
begin
// Showmessage('clique para verificação se os serviços constam na proposta...');



 memo1.Lines.Clear;
 memo1.Lines.Add('Verificação de diâmetros');
 memo1.Lines.Add('----------------------------------');
 memo1.Lines.Add('');
 memo1.Lines.Add('');
 wArquivoValido:=true;
 with uDM.dm1.tabelaEstacaDiametros do begin
   open;
   first;
   gauge1.Progress:=0;
   gauge1.MaxValue:=uDM.dm1.tabelaEstaca.RecordCount;


   while not eof do begin

     gauge1.Progress:=gauge1.Progress+1;

     wDiametroMDB:=SimpleRoundTo(strtofloat(dm1.tabelaEstacaDiametrosestDiametro.AsString),-2);
     wDiametroCadastradoSN:=consultarDiametro( wDiametroMDB );

     if (   wDiametroCadastradoSN='N'  ) then
      begin
        memo1.Lines.Add('Diâmetro: '+
                         stringreplace(FormatFloat( '###0.00' ,wDiametroMDB*100 ), ',', '.', [rfReplaceAll, rfIgnoreCase]) +
                        ' ERRO: não encontrado na proposta');
        wArquivoValido:=false;
      end
     else
      begin
        memo1.Lines.Add('Diâmetro: '+
                         stringreplace(FormatFloat( '###0.00' ,wDiametroMDB*100 ), ',', '.', [rfReplaceAll, rfIgnoreCase]) +
                        ' OK! ');
      end
     ;
     next;
   end;
   first;
   close;
 end;

 if (   wArquivoValido=false ) then begin
    showmessage('O arquivo possui registros com diâmetros que ' +#13+#10+
                'NÃO CONSTAM na proposta, o processo abortado ' +#13+#10+
                'até a devida correção.'+#13+#10+#13+#10+'acesse www.estaq.net.br');
    exit;
 end;

 pgEtapas.Pages[3].TabVisible:=true;
 pgEtapas.ActivePageIndex:=3;
end;



procedure TfrmEtapa1.DBEdit1Change(Sender: TObject);
var
 widproposta:string;
begin
 widproposta:=trimright(trimleft(uDM.dm1.tabelaObrasidproposta.AsString));
 with uDM.dm1.tabelaServicosObras do begin;
    close;
    if (widproposta<>'') then begin
     ParamByName('idproposta').AsString:=widproposta;
     open;
    end;
 end;


end;

function TfrmEtapa1.consultarDiametro(wdiametro: real): string;
var wsql:string;
var wretorno:string;
var wdiametroF:string;
var widpropostaF:string;
begin
 wdiametroF:=stringreplace(FormatFloat( '###0.00' ,wdiametro*100 ), ',', '.', [rfReplaceAll, rfIgnoreCase]);
 widpropostaF:=trimright(trimleft(dm1.tabelaObrasidproposta.AsString));

 wsql:='SELECT   case when ( coalesce(count(*),0)>0 ) then '+
       '   '+#39+'S'+#39+
       '   else '+
       '   '+#39+'N'+#39+
       '  end  '+
       '  as possui_diametro  '+
       ' FROM  '+
       '				 propostasitens pi  '+
       '				 INNER JOIN servicos se ON (se.idservico=pi.idservico)  '+
       ' WHERE  '+
       '				 pi.idproposta='+widpropostaF+' and se.diametro='+wdiametroF+
       ' ORDER BY  '+
       '                 pi.idproposta,se.diametro  ';


 with dm1.qryConsultarDiametro do begin
  close;
  sql.Clear;
  sql.Add( wsql );
  open;
  wretorno:=dm1.qryConsultarDiametropossui_diametro.AsString;
  close;
 end;
 result:=wretorno;
end;

procedure TfrmEtapa1.btEnviarSiteClick(Sender: TObject);
 var
                                        _idpatrimonio,
                                        _idobra,
                                        _idfechamento,
                                        _idservico,
                                        _sigla,
                                        _data_lcto,
                                        _estacaid,
                                        _diametro,
                                        _hora_inicio,
                                        _hora_termino,
                                        _profundidade,
                                        _concretagem_hora_inicio,
                                        _concretagem_hora_termino,
                                        _sobre_consumo,
                                        _importador_arquivo:string;

 var wDiametroMDB:real;


var
 wdescMaquina,wsql:string;
 widObra,wMDB:string;
 q:integer;
begin

 wdescMaquina:=trimRight(trimLeft(  comboMaquinas.Text ) );
 if ( wdescMaquina='' ) then begin
    showmessage('Selecione a máquina executante dos trabalhos');
    exit;
 end;

  _idpatrimonio              := FloatToStr(comboMaquinas.KeyValue);
  _idobra                    := trimleft(trimright(uDM.dm1.tabelaObrasidobra.AsString));

  wsql:='SELECT coalesce(count(*),0) as QTD  FROM obras_patrimonios where idobra='+_idobra+
        ' and idpatrimonio='+_idpatrimonio+' order by idobra,idpatrimonio ';
  with uDM.dm1.qryGeral do begin
     close;
     sql.Clear;
     sql.add(wsql);
     open;
     q:=strtoint(fieldbyname('QTD').asstring );
     close;
  end;
  if (q<=0) then begin
    MessageDlg(
                  'ERRO: MÁQUINA NÃO REGISTRADA NA OBRA '+#13+#10+#13+#10+#13+#10+
                  '-------------------------------------------------------'+#13+#10+
                  'a máquina selecionada: '+wdescMaquina+#13+#10+
                  'não está registrada na obra:'+uDM.dm1.tabelaObrasobracodigo.AsString+#13+#10+
                  '-------------------------------------------------------'+#13+#10+#13+#10+#13+#10+
                  'Acesse www.estaq.net.br e efetue a correção acessando a opção:' +#13+#10+#13+#10+#13+#10+
                  'PRODUÇÃO/OBRAS/localize a obra:'+ uDM.dm1.tabelaObrasobracodigo.AsString+'/Máquinas Alocadas'
                  ,mtError,[mbOk],0);
     exit;
  end;

   memo2.lines.clear;
   memo2.lines.Add('Processo de Lançamento de Registros de Estacas');
   memo2.lines.Add('---------------------------------------------------');

   memo2.lines.Add('');
   memo2.lines.Add('');

   memo2.lines.Add('Removendo processamentos anteriores se existirem...');
   widObra:=#39+trimright(trimleft(uDM.dm1.tabelaObrasidobra.AsString))+#39;
   wMDB:=#39+trimright(trimleft(uppercase( lblNomeMDB1.Caption)))+#39;

   wsql:='DELETE FROM obras_producao WHERE idobra=' +widObra+ ' AND  importador_arquivo='+wMDB;
   //memo2.Lines.Add(wsql);
   ExecutarSQL(wsql);


   with uDM.dm1.tabelaEstaca do begin
    gauge2.Progress:=0;
    gauge2.MaxValue:=uDM.dm1.tabelaEstaca.RecordCount;

    first;
    while not eof do begin
     gauge2.Progress:=gauge2.Progress+1;

     wDiametroMDB:=SimpleRoundTo(strtofloat(dm1.tabelaEstacaestDiametro.AsString),-2);
     _diametro:=stringreplace(FormatFloat( '###0.00' ,wDiametroMDB*100 ), ',', '.', [rfReplaceAll, rfIgnoreCase]) ;

     _idfechamento              := '0';
     _idservico                 := consultarIdDiametro(wDiametroMDB) ;
     _sigla                     := 'HC';

     //_data_lcto                 := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestData.AsString)) );
     _data_lcto               := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestInicioP.AsString)) );

     _estacaid                  := trimleft(trimright(uDM.dm1.tabelaEstacaestNumero.AsString));
     _diametro                  := trimleft(trimright(_diametro));

     _hora_inicio               := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestInicioP.AsString)) );
     _hora_termino              := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestFimP.AsString)) );

     _profundidade              := formatarRealString( uDM.dm1.tabelaEstacaestComprimento.AsFloat );

     _concretagem_hora_inicio   := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestInicioC.AsString)) );
     _concretagem_hora_termino  := formatarData( trimleft(trimright(uDM.dm1.tabelaEstacaestFimC.AsString)) );

     _sobre_consumo             := formatarRealString(strtofloat(uDM.dm1.tabelaEstacaestSuperConsumo.AsString));

     _importador_arquivo        := trimright(trimleft( uppercase( lblNomeMDB1.Caption ) ));


               memo2.Lines.Add('Processando Estaca: '+ IntToStr( Recno )+'/'+IntToStr( RecordCount ) );
                      LancarProducao(
                                        _idpatrimonio,
                                        _idobra,
                                        _idfechamento,
                                        _idservico,
                                        _sigla,
                                        _data_lcto,
                                        _estacaid,
                                        _diametro,
                                        _hora_inicio,
                                        _hora_termino,
                                        _profundidade,
                                        _concretagem_hora_inicio,
                                        _concretagem_hora_termino,
                                        _sobre_consumo,
                                        _importador_arquivo
                                        );

     next;
    end;
   end;

   showmessage('Processo de transmissão concluído...');
end;



procedure TfrmEtapa1.LancarProducao(
                                        _idpatrimonio,
                                        _idobra,
                                        _idfechamento,
                                        _idservico,
                                        _sigla,
                                        _data_lcto,
                                        _estacaid,
                                        _diametro,
                                        _hora_inicio,
                                        _hora_termino,
                                        _profundidade,
                                        _concretagem_hora_inicio,
                                        _concretagem_hora_termino,
                                        _sobre_consumo,
                                        _importador_arquivo:string);

var
 wsql:String;
 _importador_arquivo_data:string;
 myDate : TDateTime;
begin
  myDate := Now;

  _importador_arquivo_data:=  formatdatetime('yyyy-mm-dd', myDate)+' '+TimeToStr(myDate);


   wsql   :='INSERT INTO obras_producao ('+
				      ' idpatrimonio,'+
							' idobra,'+
							' idfechamento,'+
							' idservico,'+
							' sigla,'+
							' data_lcto,'+
							' estacaid,'+
							' diametro,'+
							' secaoprojeto,'+
							' hora_inicio,'+
							' hora_termino,'+
							' profundidade,'+
							' concretagem_inicio,'+
							' concretagem_termino,'+
							' sobreconsumo,'+
              ' importador_arquivo, '+
              ' importador_arquivo_data ' +
							') VALUES ('+
              #39+ _idpatrimonio+ #39+ ','+
              #39+ _idobra      + #39+ ','+
              #39+ _idfechamento+ #39+ ','+
              #39+ _idservico   + #39+ ','+
              #39+ _sigla       + #39+ ','+
              #39+ _data_lcto   + #39+ ','+
              #39+ _estacaid    + #39+ ','+
              #39+ _diametro    + #39+ ','+
              #39+ _diametro    + #39+ ','+
              #39+ _hora_inicio + #39+ ','+
              #39+ _hora_termino+ #39+ ','+
              #39+ _profundidade+ #39+ ','+
              #39+ _concretagem_hora_inicio + #39+ ','+
              #39+ _concretagem_hora_termino+ #39+ ','+
              #39+ _sobre_consumo + #39+ ', '+
              #39+ _importador_arquivo + #39+ ', '+
              #39+ _importador_arquivo_data + #39+ ' '+
							')';

             //memo2.Lines.Add(wsql);
             ExecutarSQL(wsql);



end;
function TfrmEtapa1.formatarRealString(wReal: real): string;
var
 wNro:Real;
 wRetorno:string;
begin
     wNro     :=SimpleRoundTo( wReal ,-2);
     wRetorno :=stringreplace(FormatFloat( '###0.00' ,wNro ), ',', '.', [rfReplaceAll, rfIgnoreCase]) ;
     result   :=wRetorno;
end;

function TfrmEtapa1.formatarData(wData: string): string;
var
 wdia,
 wmes,
 wano,
 whora,
 wretorno:string;
begin
    // 07/02/2020 10:22:00
    // 1234567890123456789
    wdia := copy( wData, 1 , 2 );
    wmes := copy( wData, 4 , 2 );
    wano := copy( wData, 7 , 4 );
    whora:= copy( wData,12 , 8 );

    wretorno:=wano+'-'+wmes+'-'+wdia+' '+whora;

    result:=wretorno;
end;

function TfrmEtapa1.consultarIdDiametro(wdiametro: real): string;
 var wsql:string;
 var wretorno:string;
 var wdiametroF:string;
 var widpropostaF:string;
begin
 wdiametroF:=stringreplace(FormatFloat( '###0.00' ,wdiametro*100 ), ',', '.', [rfReplaceAll, rfIgnoreCase]);
 widpropostaF:=trimright(trimleft(dm1.tabelaObrasidproposta.AsString));

 wsql:='SELECT DISTINCT COALESCE(pi.idservico,0) AS idservico '+
       ' FROM  '+
       '				 propostasitens pi  '+
       '				 INNER JOIN servicos se ON (se.idservico=pi.idservico)  '+
       ' WHERE  '+
       '				 pi.idproposta='+widpropostaF+' and se.diametro='+wdiametroF+
       ' ORDER BY  '+
       '         pi.idproposta,se.diametro  ';


 with dm1.qryConsultarIdDiametro do begin
  close;
  sql.Clear;
  sql.Add( wsql );
  open;
  wretorno:=dm1.qryConsultarIdDiametroidservico.AsString;
  close;
 end;
 result:=wretorno;
end;

procedure TfrmEtapa1.btEncerrarClick(Sender: TObject);
begin
 uDM.dm1.ADOConnection1.Close;
 uDM.dm1.ZConnection1.Connected:=false;
 application.terminate;
end;

procedure TfrmEtapa1.btRetornar4Click(Sender: TObject);
begin
 pgEtapas.Pages[3].TabVisible:=false;
 pgEtapas.ActivePageIndex:=2;
end;

procedure TfrmEtapa1.btRetornar3Click(Sender: TObject);
begin
 pgEtapas.Pages[3].TabVisible:=false;
 pgEtapas.Pages[2].TabVisible:=false;
 pgEtapas.ActivePageIndex:=1;

end;

procedure TfrmEtapa1.btRetornar2Click(Sender: TObject);
begin
 pgEtapas.Pages[3].TabVisible:=false;
 pgEtapas.Pages[2].TabVisible:=false;
 pgEtapas.Pages[1].TabVisible:=false;
 pgEtapas.ActivePageIndex:=0;

end;

function TfrmEtapa1.consultarLctoArquivo: string;
var
 widobra,wmdb,wsql,wresultado:string;
begin
 widobra:=trimright(trimleft(uDM.dm1.tabelaObrasidobra.AsString));
 wmdb:=trimright(trimleft(uppercase(lblNomeMDB1.Caption)));

 wsql:='SELECT '+
       ' DISTINCT COALESCE(importador_arquivo_data,'+#39+#39+') AS RESULTADO  '+
       ' FROM  '+
       '  obras_producao  '+
       ' WHERE  '+
       '  idobra='+ #39+ widobra+ #39+
       '  AND  '+
       '  importador_arquivo=  ' + #39+ wmdb +#39+
       ' ORDER BY  '+
       '  idobra,importador_arquivo';
 with uDM.dm1.qryGeral do begin
   close;
   sql.clear;
   sql.add(wsql);
   open;
   wresultado:=trimright(trimleft( fieldbyname('RESULTADO').AsString ));
   close;
 end;
 result:=wresultado;

end;

procedure TfrmEtapa1.ExecutarSQL(wsql: string);
begin
 uDM.dm1.zCmd.Script.Clear;
 uDM.dm1.zCmd.Script.Add(wsql);
 uDM.dm1.zCmd.Execute;
end;

initialization
 widobra:='';

end.
