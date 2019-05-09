program Untitled;
uses crt,sysutils;
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


procedure tambahdepanObat(var awal,akhir:PDataObat;data:Obat);
var
   baru:PDataObat;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if awal=nil then
     begin
          akhir:=baru;
     end
     else
     begin
          baru^.next:=awal;
          awal^.prev:=baru;
     end;
     awal := baru;
     akhir^.next := awal;
     awal^.prev := akhir;
end;


Procedure TambahRecordObat(info : obat; id_obat, nama_obat : String; harga, stok : Integer);
Begin
 SRecObat.id_obat   := id_obat;
 SRecObat.nama_obat := nama_obat;
 SRecObat.harga     := harga;
 SRecObat.stok      := stok;
End;


procedure tampil(awal,akhir:PDataObat);
var
   bantu:PDataObat;
begin
     if awal=nil then
        writeln('Data tidak ada')
     else
     begin
          writeln('ID Obat     Nama Obat     Harga    Stok');
          bantu:=awal;
          while bantu<>akhir do
          begin
               write(bantu^.info.id_obat,'       ',bantu^.info.nama_obat,'       ',
               bantu^.info.harga,'       ',bantu^.info.stok);
               writeln;
               bantu:=bantu^.next;
               end;
     end;

end;

procedure simpankefile;
var
   f:file of Obat;
   bantu:PDataObat;
begin
     assign(f,'testobat.dat');
     rewrite(f);
     bantu:=awal;
	 while bantu<>akhir do
     begin
          write(f,bantu^.info);
          bantu:=bantu^.next;
     end;
     writeln(' Data Telah Disimpan Ke File');
     readln;
end;

procedure bacadarifile;
var
   c:file of Obat;
   bantu:PDataObat;
   obatBaru:Obat;
begin
     if fileexists('testobat.dat') then
     begin
          assign(c,'testobat.dat');
          reset(c);
          //write('test');
          penciptaan(awal,akhir);
          while not eof(c) do
          begin
               read(c,obatBaru);
               TambahRecordObat(SRecObat,obatBaru.id_obat,obatBaru.nama_obat,obatBaru.harga,obatBaru.stok);
               tambahdepanObat(awal,akhir,SRecObat);
          end;

          close(c);
          writeln('Baca data selesai. ');
          readln;
     end
     else
     begin
          writeln('File Belum Ada. Tidak ada data yang terbaca');readln;
     end;


end;





begin
     penciptaan(awal,akhir);
     //bacadarifile;

     writeln('tampilin dari file');
     tampil(awal,akhir);
     writeln;
     writeln;
     write('data setelah ditambah');
     writeln;
     TambahRecordObat(SRecObat,'005','Alkohol',30000,70);
     tambahdepanObat(awal,akhir,SRecObat);tampil(awal,akhir);
     TambahRecordObat(SRecObat,'006','Antimo',2500,89);
     tambahdepanObat(awal,akhir,SRecObat);tampil(awal,akhir);
     TambahRecordObat(SRecObat,'007','Panadol',7500,7);
     tambahdepanObat(awal,akhir,SRecObat);tampil(awal,akhir);
     TambahRecordObat(SRecObat,'008','Amoxsilin',3621,33);
     tambahdepanObat(awal,akhir,SRecObat);tampil(awal,akhir);
     TambahRecordObat(SRecObat,'009','Bodrex',3621,33);
     tambahdepanObat(awal,akhir,SRecObat);tampil(awal,akhir);




     //simpankefile;



     readln;
end.
