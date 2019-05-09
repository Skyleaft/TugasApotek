program DataApotek;
uses crt,sysutils;
const
     maks=100;
     maksPinjaman=1000;
     maks_menu=12;
     garis_kiri=5;
     garis_kanan=60;
     garis_atas=3;
     garis_bawah=17;
     atas=#72;
     bawah=#80;
     enter=#13;
     kiri=#75;
     kanan=#77;
type
    TAnggota=record
                   id_anggota:string;
                   nama:string;
                   alamat:string;
                   no_telp:string;
                   pekerjaan:string;
                   saldo:real;
    end;
    TPinjaman=record
                   kd_pinjaman:string;
                   id_anggota:string;
                   tgl_pinjam:string;
                   jml_pinjam:real;
                   lama:integer;
                   bunga:real;
                   total:real;
                   angsuran:real;
                   end;
    TKaryawan=record
                    id_karyawan:string;
                    nama_karyawan:string;
                    jk:string;
                    tgl_lahir:string;
                    alamat:string;
                    no_tlp:string;
    end;

    Obat=record
                id_obat:string;
                nama_obat:string;
                jenis:string;
                harga:integer;
                stok:integer;
    end;

    PDataObat=^TDataObat;
    TDataObat=record
                    info:Obat;
                    next,prev:PDataObat;
     end;
//----------------------------------------------------------------------------------------------------------------------

    data_menu=array[1..maks_menu] of string;



//global Variable
var
   SRecObat:Obat;
   awal,akhir:PDataObat;

   data_anggota:Array[1..maks] of TAnggota;
   data_pinjaman:Array[1..maksPinjaman] of TPinjaman;
   Tmenu:data_menu;
   bd,bdpinjam,pil:integer;
   YYYY,MM,DD : Word;




//----------------------------------------------------------------------------------------------------------------------
//FRAME
//----------------------------------------------------------------------------------------------------------------------
procedure kotak(kiri,kanan,atas,bawah:integer;
                latar,tulisan:integer;judul:string);
var
   i:integer;
begin
     textcolor(tulisan);textbackground(latar);
     window(kiri,atas,kanan,bawah);
     clrscr;
     window(1,1,120,30);
     gotoxy(kiri,atas);write(chr(218));
     gotoxy(kanan,atas);write(chr($BF));
     gotoxy(kiri,bawah);write(#192);
     gotoxy(kanan,bawah);write(#217);
     for i:=kiri+1 to kanan-1 do
     begin
          gotoxy(i,atas);write(#196);gotoxy(i,bawah);write(#196);
     end;
     for i:=atas+1 to bawah-1 do
     begin
          gotoxy(kiri,i);write(#179);gotoxy(kanan,i);write(#179);
     end;
     gotoxy(((kanan-kiri)-length(judul)) div 2+kiri, atas+1);write(judul);
end;

procedure pemisah(kiri,kanan,atas:integer);
var
   i:integer;
begin
     gotoxy(kiri,atas);write(#195);
     for i:=kiri+1 to kanan-1 do
     begin
          gotoxy(i,atas);write(#196);
     end;
     gotoxy(kanan,atas);write(#180);
     writeln;
end;

procedure bersihin();
begin
     textcolor(0);textbackground(0);
     window(1,1,120,30);
     clrscr;
end;

//----------------------------------------------------------------------------------------------------------------------




procedure penciptaan(var awal,akhir:PDataObat);
begin
     awal:=nil;
     akhir:=nil;
end;



//----------------------------------------------------------------------------------------------------------------------
//tambah data obat
//----------------------------------------------------------------------------------------------------------------------
Procedure TambahRecordObat(info : obat; id_obat, nama_obat, jenis : String; harga, stok : Integer);
Begin
     SRecObat.id_obat   := id_obat;
     SRecObat.nama_obat := nama_obat;
     SRecObat.jenis     := jenis;
     SRecObat.harga     := harga;
     SRecObat.stok      := stok;
End;

procedure sisipdepanObat(var awal,akhir:PDataObat;data:Obat);
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

procedure sisipbelakangObat(var awal,akhir:PDataObat;data:Obat);
var
   baru:PDataObat;
begin
     new(baru);
     baru^.info := data;   
     baru^.next:=nil;
     baru^.prev:=nil;
     if (awal = nil) then
        sisipdepanObat(awal,akhir,data)
     else
         begin
           akhir^.next := baru;
           baru^.prev := akhir;
           akhir := baru;
           akhir^.next := awal;
           awal^.prev := akhir;
         end;
end;




procedure tambah_Obat;
var
   Rid_obat,Rnama_obat,Rjenis:string;
   Rharga,Rstok:integer;
begin
     clrscr;
     bersihin;
          kotak(4,50,2,20,BLUE,WHITE,'Tambah Data Anggota');
          pemisah(4,50,4);

          gotoxy(6,5);writeln('Masukan Data Obat ');
          gotoxy(6,6);write('id Obat    : ');readln(Rid_obat);
          gotoxy(6,7);write('Nama Obat  : ');readln(Rnama_obat);
          gotoxy(6,8);write('Jenis      : ');readln(Rjenis);
          gotoxy(6,9);write('Harga      : ');readln(Rharga);
          gotoxy(6,10);write('Stok      : ');readln(Rstok);

          TambahRecordObat(SRecObat,Rid_obat,Rnama_obat,Rjenis,Rharga,Rstok);
          sisipdepanObat(awal,akhir,SRecObat);

          gotoxy(6,12);write('Data berhasil Disimpan');


          gotoxy(6,16);write('Tekan enter untuk kembali ke menu');
          read;

end;
//----------------------------------------------------------------------------------------------------------------------










//----------------------------------------------------------------------------------------------------------------------
//TAMPIL DATA Obat
//----------------------------------------------------------------------------------------------------------------------
procedure tampil_dataObat(awal,akhir:PDataObat);
var
   i,j,y : integer;
   bantu:PDataObat;
begin
     bersihin;
     clrscr;
     kotak(1,120,1,30,BLUE,WHITE,'Data Obat');
     pemisah(1,120,3);
     //                                   1234567890123456789012        1234567890123      1234567890123456       12345678901234
     gotoxy(4,4);writeln(' ID Obat ',#179,'      Nama Obat      ',#179,'    Jenis   ',#179,'    Harga    ',#179,'  Stok  ',#179);
     
     if awal=nil then
     begin
          write('Pesan : Data Kosong. Tekan Enter Untuk Kembali !');
     end
     else
     begin
          bantu:=awal;
          j :=1;
          while bantu<>akhir do
          begin
               bantu:=bantu^.next;
               j:=j+1;
          end;
          bantu:=awal;
          y:=1;
          for i:=1 to j do
          begin
               bantu:=bantu^.next;
               gotoxy(4,4+y);
               writeln(' ',bantu^.info.id_obat:7,' ',#179,' ',bantu^.info.nama_obat:19,' ',#179,' ',bantu^.info.jenis:10,' ',#179,' Rp.',bantu^.info.harga:8,' ',#179,' ',bantu^.info.stok:5,'  ',#179);
               y:=y+1;
          end;

          pemisah(1,120,27);
          gotoxy(4,28);write('Jumlah Obat : ',j);
          gotoxy(4,29);write('Tekan enter untuk kembali ke menu                                                        !note : Jangan di maximize');
     end;
     read;
end;

//----------------------------------------------------------------------------------------------------------------------




//----------------------------------------------------------------------------------------------------------------------
//TAMPIL DATA PINJAMAN
//----------------------------------------------------------------------------------------------------------------------
procedure tampil_pinjaman;
var
   i:integer;
begin
     bersihin;
     clrscr;

     kotak(2,120,2,29,BLUE,WHITE,'Data Pinjaman');
     pemisah(2,120,4);
     //writeln('-------------------------------------------------------');
     gotoxy(10,6);writeln('Kode ',#179,' ID Anggota ',#179,'  Tanggal  ',#179,' Nominal Pinjam  ',#179,'    Lama   ',#179,' Bunga ',#179,'      Total      ',#179,'    Angsuran    ');
     for i:=1 to bdpinjam do
     begin
         gotoxy(8,6+i);writeln(' ',data_pinjaman[i].kd_pinjaman,' ',#179,'     ',data_pinjaman[i].id_anggota,'    ',#179,'  ',data_pinjaman[i].tgl_pinjam,' ',#179,'  Rp.',data_pinjaman[i].jml_pinjam:0:0,'     ',#179,'  ',data_pinjaman[i].lama,' Bulan ',#179,'   ',data_pinjaman[i].bunga:0:0,'%  ',#179,'   Rp.',data_pinjaman[i].total:0:0,'    ',#179,'   Rp.',data_pinjaman[i].angsuran:0:0);
     end;
     gotoxy(4,27);write('Tekan enter untuk kembali ke menu');
     read;
end;



//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//UBAH DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
var
   terpilih:integer;
   tombol:char;

procedure tulis_menuUbah;
var
   i:integer;
begin
     bersihin;
     kotak(4,40,2,20,BLUE,WHITE,'Ubah Data Anggota');
     pemisah(4,40,4);
     gotoxy(5,5);writeln('Pilih Data yang mau diubah');
     gotoxy(10,7);writeln('ID Anggota ',#179,' Nama Anggota ');
     for i:=1 to bd do
         begin
              if terpilih = i then
              begin
                   textbackground(4);
                   gotoxy(10,7+i);writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end
              else
              begin
                   textbackground(blue);
                   gotoxy(10,7+i);writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end;

     end;
end;

procedure ubah_Anggota(index:integer);
var
   nama,alamat,no_telp,pekerjaan:string;
begin
     bersihin;
     kotak(4,65,2,20,BLUE,WHITE,'Ubah Data Anggota');
     pemisah(4,65,4);

     gotoxy(5,5);writeln('Data yang Mau Di Ubah ID : ',data_anggota[index].id_anggota);
     gotoxy(5,6);writeln('Kosongkan yang tidak diubah');
     gotoxy(5,8);write('Nama       : ',data_anggota[index].nama,'   Ubah  : ');readln(nama);
     gotoxy(5,9);write('Alamat     : ',data_anggota[index].alamat,'   Ubah  : ');readln(alamat);
     gotoxy(5,10);write('No Telepon : ',data_anggota[index].no_telp,'   Ubah  : ');readln(no_telp);
     gotoxy(5,11);write('pekerjaan  : ',data_anggota[index].pekerjaan,'   Ubah  : ');readln(pekerjaan);
     if nama<>'' then
        data_anggota[index].nama:=nama;
     if alamat<>'' then
        data_anggota[index].alamat:=alamat;
     if no_telp<>'' then
        data_anggota[index].no_telp:=no_telp;
     if pekerjaan<>'' then
        data_anggota[index].pekerjaan:=pekerjaan;

     gotoxy(5,15);write('Data berhasil Di Ubah');
     gotoxy(5,16);write('Tekan enter untuk kembali ke menu');
     read;

end;

procedure pilih_AnggotaUbah;
var
   i:integer;
begin
     terpilih:=1;
     repeat
     clrscr;
     tulis_menuUbah;

     tombol:=readkey;
     if tombol=bawah then
     begin
          if terpilih <> bd then
             terpilih:=terpilih+1;
     end

     else if tombol=atas then
     begin
          terpilih:=terpilih-1;
          if terpilih = 0 then
             terpilih:=terpilih+1;
     end
     else if tombol=enter then
     begin
          clrscr;
          ubah_Anggota(terpilih);
     end;


     //readln(i);
     //terpilih:=i;
     until tombol=enter;
end;

//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//HAPUS DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
var
   terpilih2:integer;

procedure tulis_menuHapus;
var
   i:integer;
begin
     bersihin;
     kotak(4,40,2,20,BLUE,WHITE,'Hapus Data Anggota');
     pemisah(4,40,4);
     gotoxy(5,5);writeln('Pilih Data yang mau diubah');
     gotoxy(10,7);writeln('ID Anggota ',#179,' Nama Anggota ');
     for i:=1 to bd do
         begin
              if terpilih2 = i then
              begin
                   textbackground(4);
                   gotoxy(10,7+i);writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end
              else
              begin
                   textbackground(blue);
                   gotoxy(10,7+i);writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end;

     end;
end;

procedure hapus_Anggota(index:integer);
var
   yt:char;
   x:integer;
   temp:TAnggota;
begin
     bersihin;
     kotak(4,55,2,10,BLUE,WHITE,'Hapus Data Anggota');
     pemisah(4,55,4);

     gotoxy(5,5);write('Hapus Data ID:',data_anggota[index].id_anggota,'  Atas Nama : ',data_anggota[index].nama,' ?(y/t)');
     read(yt);
     if upcase(yt) = 'Y' then
     begin
          temp:=data_anggota[index+1];
          for x:=index to bd do
          begin
               data_anggota[x]:=temp;
               temp:=data_anggota[index+x+1];
          end;
        bd:=bd-1;
        gotoxy(5,7);write('Data Berhasil Dihapus');
     end
     else if upcase(yt) = 'T' then
     begin
          gotoxy(5,7);write('Hapus Dibatalkan');
     end;
     gotoxy(5,8);write('Tekan enter untuk kembali ke menu');
     readln;
end;

procedure pilih_AnggotaHapus;
var
   i:integer;
begin
     terpilih2:=1;
     repeat
     clrscr;
     tulis_menuHapus;

     tombol:=readkey;
     if tombol=bawah then
     begin
          if terpilih2 <> bd then
             terpilih2:=terpilih2+1;
     end

     else if tombol=atas then
     begin
          terpilih2:=terpilih2-1;
          if terpilih2 = 0 then
             terpilih2:=terpilih2+1;
     end
     else if tombol=enter then
     begin
          clrscr;
          hapus_Anggota(terpilih2);
     end;


     //readln(i);
     //terpilih:=i;
     until tombol=enter;
end;



//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//PENGURUTAN DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
procedure pengurutan_idAnggota();
var
   i,j:integer;
   temp:TAnggota;
begin
   for i:=1 to bd-1 do
   begin
        for j:=bd downto i+1 do
        begin
             if data_anggota[j].id_anggota < data_anggota[j-1].id_anggota then
             begin
                  temp:=data_anggota[j];
                  data_anggota[j]:=data_anggota[j-1];
                  data_anggota[j-1]:=temp;
             end;
        end;
   end;
   gotoxy(5,12);writeln('Pengurutan Selesai. Tekan Enter untuk melanjutkan');read;
end;

procedure pengurutan_namaAnggota();
var
   i,j:integer;
   temp:TAnggota;
begin
   for i:=1 to bd-1 do
   begin
        for j:=bd downto i+1 do
        begin
             if data_anggota[j].nama < data_anggota[j-1].nama then
             begin
                  temp:=data_anggota[j];
                  data_anggota[j]:=data_anggota[j-1];
                  data_anggota[j-1]:=temp;
             end;
        end;
   end;
   gotoxy(5,12);writeln('Pengurutan Selesai. Tekan Enter untuk melanjutkan');read;
end;

procedure pengurutan_saldoAnggota();
var
   i,j:integer;
   temp:TAnggota;
begin
   for i:=1 to bd-1 do
   begin
        for j:=bd downto i+1 do
        begin
             if data_anggota[j].saldo < data_anggota[j-1].saldo then
             begin
                  temp:=data_anggota[j];
                  data_anggota[j]:=data_anggota[j-1];
                  data_anggota[j-1]:=temp;
             end;
        end;
   end;
   gotoxy(5,12);writeln('Pengurutan Selesai. Tekan Enter untuk melanjutkan');read;
end;




procedure pengurutan_Anggota;
var
   pil:integer;
begin
     bersihin;
     clrscr;
     kotak(4,55,2,17,BLUE,WHITE,'Pengurutan Data Anggota');
     pemisah(4,55,4);
     gotoxy(5,5);writeln('1. Pengurutan Berdasarkan ID');
     gotoxy(5,6);writeln('2. Pengurutan Berdasarkan Nama Anggota');
     gotoxy(5,7);writeln('3. Pengurutan Berdasarkan Saldo');
     gotoxy(5,8);writeln('----------------------------------------');
     gotoxy(5,9);write('Pilihan : ');readln(pil);
     case pil of
          1: pengurutan_idAnggota;
          2: pengurutan_namaAnggota;
          3: pengurutan_saldoAnggota;
     end;
end;
//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
//PENCARIAN DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
procedure pencarian_idAnggota;
var
   cari:string;
   i,x:integer;
   temp:TAnggota;
begin
     bersihin;
     clrscr;
     kotak(4,55,2,17,BLUE,WHITE,'Pencarian Berdasarkan ID Anggota');
     pemisah(4,55,4);
     gotoxy(5,5);write('Masukan ID Anggota : ');readln(cari);
     i:=1;
     while (data_anggota[i].id_anggota <> cari) and (i<bd) do
           i:=i+1;
     if data_anggota[i].id_anggota = cari then
     begin
        gotoxy(5,7);writeln(cari,' ditemukan di indeks ke-',i);
        gotoxy(5,8);writeln('ID Anggota : ',data_anggota[i].id_anggota);
        gotoxy(5,9);writeln('Nama       : ',data_anggota[i].nama);
        gotoxy(5,10);writeln('Alamat     : ',data_anggota[i].alamat);
        gotoxy(5,11);writeln('Pekerjaan  : ',data_anggota[i].pekerjaan);
        gotoxy(5,12);writeln('Saldo      : ',data_anggota[i].saldo:0:0);
     end
     else
     begin
        gotoxy(5,6);writeln(cari,' tidak ditemukan');
     end;
     gotoxy(5,13);write('Tekan enter untuk kembali ke menu');
     read;
end;

procedure pencarian_namaAnggota;
var
   cari:string;
   i,x:integer;
   temp:TAnggota;
begin
     bersihin;
     clrscr;
     kotak(4,55,2,17,BLUE,WHITE,'Pencarian Berdasarkan Nama Anggota');
     pemisah(4,55,4);
     gotoxy(5,5);write('Masukan Nama Anggota : ');readln(cari);
     i:=1;
     while (data_anggota[i].nama <> cari) and (i<bd) do
           i:=i+1;
     if data_anggota[i].nama = cari then
     begin
        gotoxy(5,7);writeln(cari,' ditemukan di indeks ke-',i);
        gotoxy(5,8);writeln('ID Anggota : ',data_anggota[i].id_anggota);
        gotoxy(5,9);writeln('Nama       : ',data_anggota[i].nama);
        gotoxy(5,10);writeln('Alamat     : ',data_anggota[i].alamat);
        gotoxy(5,11);writeln('Pekerjaan  : ',data_anggota[i].pekerjaan);
        gotoxy(5,12);writeln('Saldo      : ',data_anggota[i].saldo:0:0);
     end
     else
     begin
        gotoxy(5,6);writeln(cari,' tidak ditemukan');
     end;
     gotoxy(5,13);write('Tekan enter untuk kembali ke menu');
     read;
end;



procedure pencarian_Anggota;
var
   pil:integer;
begin
     bersihin;
     clrscr;
     kotak(4,55,2,17,BLUE,WHITE,'Pencarian Data Anggota');
     pemisah(4,55,4);
     gotoxy(5,5);writeln('1. pencarian Berdasarkan ID Anggota');
     gotoxy(5,6);writeln('2. pencarian Berdasarkan Nama Anggota');
     gotoxy(5,7);writeln('----------------------------------------');
     gotoxy(5,8);write('Pilihan : ');readln(pil);
     case pil of
     1: pencarian_idAnggota;
     2: pencarian_namaAnggota;
     end;
end;
//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//PINJAMAN
//----------------------------------------------------------------------------------------------------------------------
procedure pinjaman;
var
   id:string;
   i,index,lama:integer;
   ketemu:boolean;
   tanggal,kdpinjam:string;
   nominal,bunga,total,angsuran:real;
   tbunga:real;


begin
     bersihin;
     clrscr;
     kotak(4,66,2,25,BLUE,WHITE,'Pinjaman');
     pemisah(4,66,4);
     gotoxy(5,5);writeln('Masukan Data Anggota');
     gotoxy(5,6);write('ID Anggota : ');readln(id);
     for i:=1 to bd do
         if id = data_anggota[i].id_anggota then
         begin
              ketemu:=true;
              index:=i;
         end;
         if ketemu = true then
         begin
              gotoxy(5,8);writeln('Nama Anggota : ',data_anggota[index].nama);
              gotoxy(5,9);writeln('Alamat       : ',data_anggota[index].alamat);
              gotoxy(5,10);writeln('Saldo        : Rp.',data_anggota[index].saldo:0:2);


              writeln;
              bdpinjam:=bdpinjam+1;
              kdpinjam:='PJ00';
              data_pinjaman[bdpinjam].kd_pinjaman:=kdpinjam+IntToStr(bdpinjam);
              gotoxy(5,12);Writeln ('Kode Pinjaman : ',data_pinjaman[bdpinjam].kd_pinjaman);

              data_pinjaman[bdpinjam].id_anggota:=data_anggota[index].id_anggota;


              DeCodeDate (Date,YYYY,MM,DD);
              tanggal:=format('%d/%d/%d',[dd,mm,yyyy]);
              gotoxy(5,13);Writeln ('Tanggal Pinjam : ',tanggal);
              data_pinjaman[bdpinjam].tgl_pinjam:=tanggal;

              gotoxy(5,14);write('Masukan Nominal Pinjam : Rp.');readln(nominal);
              gotoxy(5,15);write('Lama Pinjaman(Bulan) : ');readln(lama);
              gotoxy(5,16);write('Bunga(Persen) : ');readln(bunga);
              tbunga:=(bunga/100)*nominal;

              total:=nominal+tbunga;
              gotoxy(5,18);writeln('Total : Rp.',total:0:0);

              angsuran:=total/lama;
              gotoxy(5,19);writeln('Angsuran : Rp.',angsuran:0:0);

              data_pinjaman[bdpinjam].jml_pinjam:=nominal;
              data_pinjaman[bdpinjam].lama:=lama;
              data_pinjaman[bdpinjam].bunga:=bunga;
              data_pinjaman[bdpinjam].total:=total;
              data_pinjaman[bdpinjam].angsuran:=angsuran;

              gotoxy(5,23);write('Tekan Enter untuk kembali ke Menu');
              read;
          end
          else
              writeln('Data Tidak Ditemukan');
          readln;
end;
//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
procedure simpansemuafile;
var
   f:file of Obat;
   bantu:PDataObat;
   i,j:integer;
begin
     assign(f,'DataObat.dat');
     rewrite(f);

     bantu:=awal;
     j :=1;
     while bantu<>akhir do
     begin
          bantu:=bantu^.next;
          j:=j+1;
     end;
     bantu:=awal;
     for i:=1 to j do
     begin
          bantu:=bantu^.next;
          write(f,bantu^.info);

     end;

     writeln(j,' Data Telah Disimpan Ke File');
     readln;
end;
//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
procedure bacasemuafile;
var
   c:file of Obat;
   bantu:PDataObat;
   obatBaru:Obat;
   j:integer;
begin
     if fileexists('DataObat.dat') then
     begin
          assign(c,'DataObat.dat');
          reset(c);
          //write('test');
          penciptaan(awal,akhir);
          while not eof(c) do
          begin
               read(c,obatBaru);
               TambahRecordObat(SRecObat,obatBaru.id_obat,obatBaru.nama_obat,obatBaru.jenis,obatBaru.harga,obatBaru.stok);
               sisipdepanObat(awal,akhir,SRecObat);
          end;

          close(c);
           j :=1;
           bantu:=awal;
           while bantu<>akhir do
           begin
                bantu:=bantu^.next;
                j:=j+1;
           end;

          writeln('Baca data selesai. Terbaca ',j,' data');
     end
     else
     begin
          writeln('File Belum Ada. Tidak ada data yang terbaca');readln;
     end;

end;
//----------------------------------------------------------------------------------------------------------------------




//----------------------------------------------------------------------------------------------------------------------
//MENU
//----------------------------------------------------------------------------------------------------------------------
procedure isi_menu;
begin
     Tmenu[1]:=' 1. Tambah Obat       ';
     Tmenu[2]:=' 2. Tampil Data Obat    ';
     Tmenu[3]:=' 3.     ';
     Tmenu[4]:=' 4.      ';
     Tmenu[5]:=' 5.          ';
     Tmenu[6]:=' 6.          ';
     Tmenu[7]:=' 7.                   ';
     Tmenu[8]:=' 8.                  ';
     Tmenu[9]:=' 9.             ';
     Tmenu[10]:=' 10.  ';
     Tmenu[11]:=' 11. Simpan Ke File      ';
     Tmenu[12]:=' 12. Keluar                   ';
end;

procedure tulis_menu;
var
   i:integer;
begin
for i:=1 to maks_menu do
     begin
          if terpilih = i then
          begin
               textbackground(4);
               writeln(Tmenu[i]);
          end
          else
          begin
               textbackground(blue);
               writeln(Tmenu[i]);

          end;

     end;
end;

procedure buka_menu(t:integer);
begin
     case t of
          1:tambah_Obat;
          2:tampil_dataObat(awal,akhir);
          3:;
          4:;
          5:;
          6:;
          7:;
          8:;
          9:;
          10:;
          11:simpansemuafile;
     end;
end;

procedure seleksi_menu;
begin
     terpilih:=1;
     repeat
           clrscr;
           isi_menu;
           tulis_menu;

           tombol:=readkey;
           if tombol=bawah then
           begin
                if terpilih <> maks_menu then
                   terpilih:=terpilih+1;
           end
           else if tombol=atas then
           begin
                terpilih:=terpilih-1;
                if terpilih = 0 then
                   terpilih:=terpilih+1;
           end
           else if tombol=enter then
           begin
                clrscr;
                buka_menu(terpilih);
           end;

     until tombol=enter;
end;


procedure testisi;
begin

     TambahRecordObat(SRecObat,'005','Alkohol','botol',30000,70);
     sisipdepanObat(awal,akhir,SRecObat);
     TambahRecordObat(SRecObat,'006','Antimo','tablet',2500,89);
     sisipdepanObat(awal,akhir,SRecObat);
     TambahRecordObat(SRecObat,'007','parah','botol',7500,7);
     sisipdepanObat(awal,akhir,SRecObat);

end;



//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//mulai disini
//----------------------------------------------------------------------------------------------------------------------
begin
penciptaan(awal,akhir);

     bd:=0;
     bdpinjam:=0;
     bacasemuafile;

     testisi;

     readln;

     repeat
     bersihin;
     clrscr;

     kotak(3,55,2,20,BLUE,WHITE,'Aplikasi Apotek');
     pemisah(3,55,4);



     kotak(78,113,2,9,Blue,White,'Catatan');
     pemisah(78,113,4);
     window(79,5,112,8);
     writeln('-Gunakan arrow key atas dan bawah');
     writeln(' untuk pindah menu');
     writeln('-Tekan Enter Untuk Memilih');


     window(5,5,52,19);
     seleksi_menu;

     readln;
     until terpilih=12;

     read;
end.
