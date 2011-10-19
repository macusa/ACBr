unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrCargaBal, ACBrBase;

type
  TfrmPrincipal = class(TForm)
    ACBrCargaBal1: TACBrCargaBal;
    cbxModelo: TComboBox;
    edtDiretorio: TEdit;
    btnEscolherDiretorio: TButton;
    btnGerarArquivo: TButton;
    btnFechar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGerarArquivoClick(Sender: TObject);
    procedure btnEscolherDiretorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  FileCtrl;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  cbxModelo.ItemIndex := 0;
  edtDiretorio.Clear;
end;

procedure TfrmPrincipal.btnEscolherDiretorioClick(Sender: TObject);
var
  Diretorio: String;
begin
  if SelectDirectory('Selecione o diret�rio onde ser�o gerados os arquivos:', '', Diretorio) then
    edtDiretorio.Text := Diretorio;
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.btnGerarArquivoClick(Sender: TObject);
var
  I: Integer;
begin
  try
    // defini��o do modelo do arquivo, utilizado para padronizar o layout
    // conforme a balan�a para a qual se vai gerar o arquivo
    ACBrCargaBal1.Modelo := TACBrCargaBalModelo(cbxModelo.ItemIndex);

    // adi��o dos itens que ser�o gerados no arquivo
    ACBrCargaBal1.Produtos.Clear;
    for I := 0 to 50 do
    begin
      with ACBrCargaBal1.Produtos.New do
      begin
        ModeloEtiqueta  := 1;
        Tipo            := tpvPeso;
        Codigo          := I;
        Descricao       := Format('Descricao item %d', [I]);
        ValorVenda      := 1.23;
        Validade        := 15;
        Tecla           := 0;
        Receita         := Format('Receita do item %d', [I]);
        Setor.Codigo    := 1;
        Setor.Descricao := 'GERAL';
      end;
    end;

    // gerar os arquivos para o diret�rio, informe somente o caminho do diret�rio
    ACBrCargaBal1.GerarArquivos(edtDiretorio.Text);
    ShowMessage('Arquivo gerado com sucesso!');
  except
    on E: Exception do
    begin
      // todo erro do componente levanta uma excess�o
      ShowMessage('Ocorreu o seguinte erro:' + sLineBreak + E.Message);
    end;
  end;
end;

end.