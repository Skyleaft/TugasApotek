program Untitled;
type
    Obat=record
               id_obat:string;
               nama_obat:string;
               harga:integer;
               stok:integer;
    end;

    PDataObat=^TDataObat;
    TDataObat=record
                    info:Obat;
                    next,prev:PDataObat;
     end;
var
   SRecObat:Obat;
   awal,akhir:PDataObat;


procedure penciptaan(var awal,akhir:PDataObat);
begin
     awal:=nil;
     akhir:=nil;
end;

procedure tambahdepan(var awal,akhir:PDataObat;data:Obat);
var
   baru:PDataObat;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if awal=nil then
     begin
          awal:=baru;
          akhir:=baru;
     end
     else
     begin
          baru^.next:=awal;
          awal^.prev:=baru;
          awal:=baru;
     end;
end;

procedure tampil(awal,akhir:PDataObat);
var
   bantu:PDataObat;
begin
     writeln('ID Obat     Nama Obat     Harga    Stok');
     bantu:=awal;
     while bantu<>nil do
     begin
          write(bantu^.info.id_obat,'       ',bantu^.info.nama_obat,'       ',
          bantu^.info.harga,'       ',bantu^.info.stok);
          writeln;
          bantu:=bantu^.next;
     end;

end;

Procedure AssignRecordObat(info : obat; id_obat, nama_obat : String; harga, stok : Integer);
Begin
 SRecObat.id_obat   := id_obat;
 SRecObat.nama_obat := nama_obat;
 SRecObat.harga     := harga;
 SRecObat.stok      := stok;
End;



begin
     penciptaan(awal,akhir);
     AssignRecordObat(SRecObat,'001','parasetamol',2000,30);
     tambahdepan(awal,akhir,SRecObat);
     AssignRecordObat(SRecObat,'002','asdawd',6000,10);
     tambahdepan(awal,akhir,SRecObat);
     AssignRecordObat(SRecObat,'003','asawgawghwahdawd',7500,4);
     tambahdepan(awal,akhir,SRecObat);
     AssignRecordObat(SRecObat,'004','wetwetwqw',26000,16);
     tambahdepan(awal,akhir,SRecObat);


     tampil(awal,akhir);

     readln;
end.
