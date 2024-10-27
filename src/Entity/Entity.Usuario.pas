unit Entity.Usuario;

interface

type
  TUsuario = class
    private
      fIdUsuario: integer;
      fNome: string;
    public
      property IdUsuario: integer read fIdUsuario write fIdUsuario;
      property Nome: string read fNome write fNome;
  end;

implementation

end.
