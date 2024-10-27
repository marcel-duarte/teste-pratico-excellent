unit Entity.Cliente;

interface

type
  TCliente = class
    private
      fIdCliente: integer;
      fNome: string;
    public
      property IdCliente: integer read fIdCliente write fIdCliente;
      property Nome: string read fNome write fNome;
  end;

implementation

end.
