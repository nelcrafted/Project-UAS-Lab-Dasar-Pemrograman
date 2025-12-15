program DiagnosaPenyakit;
uses crt;

type
    TPenyakit = record
        nama: string;
        gejala: array[1..10] of string; // maksimal 10 gejala per penyakit
    end;

var
    daftarPenyakit: array[1..10] of TPenyakit; // total 10 penyakit
    gejalaUser: array[1..10] of string; // gejala dari user
    jumlahGejala: integer;

function IntToStrSimple(n: integer): string;
var
    s: string;
begin
    Str(n, s);            // konversi integer ke string
    IntToStrSimple := s;
end;

procedure InisialisasiData;
var
    i, j: integer;
begin
    // Set semua gejala kosong dulu
    for i := 1 to 10 do
        for j := 1 to 10 do
            daftarPenyakit[i].gejala[j] := '';

    // Penyakit 1
    daftarPenyakit[1].nama := 'Flu';
    daftarPenyakit[1].gejala[1] := 'demam';
    daftarPenyakit[1].gejala[2] := 'batuk';
    daftarPenyakit[1].gejala[3] := 'pilek';
    daftarPenyakit[1].gejala[4] := 'sakit kepala';

    // Penyakit 2
    daftarPenyakit[2].nama := 'Demam Berdarah';
    daftarPenyakit[2].gejala[1] := 'demam tinggi';
    daftarPenyakit[2].gejala[2] := 'nyeri sendi';
    daftarPenyakit[2].gejala[3] := 'ruam kulit';
    daftarPenyakit[2].gejala[4] := 'sakit kepala';
    daftarPenyakit[2].gejala[5] := 'mual';

    // Penyakit 3
    daftarPenyakit[3].nama := 'Maag';
    daftarPenyakit[3].gejala[1] := 'nyeri perut';
    daftarPenyakit[3].gejala[2] := 'mual';
    daftarPenyakit[3].gejala[3] := 'perut kembung';
    daftarPenyakit[3].gejala[4] := 'asam lambung naik';

    // Penyakit 4
    daftarPenyakit[4].nama := 'Tifus';
    daftarPenyakit[4].gejala[1] := 'demam';
    daftarPenyakit[4].gejala[2] := 'lemas';
    daftarPenyakit[4].gejala[3] := 'mual';
    daftarPenyakit[4].gejala[4] := 'sakit perut';
    daftarPenyakit[4].gejala[5] := 'diare';

    // Penyakit 5
    daftarPenyakit[5].nama := 'Asma';
    daftarPenyakit[5].gejala[1] := 'sesak napas';
    daftarPenyakit[5].gejala[2] := 'batuk';
    daftarPenyakit[5].gejala[3] := 'dada terasa berat';

    // Penyakit 6
    daftarPenyakit[6].nama := 'Hipertensi';
    daftarPenyakit[6].gejala[1] := 'pusing';
    daftarPenyakit[6].gejala[2] := 'penglihatan kabur';
    daftarPenyakit[6].gejala[3] := 'mudah lelah';

    // Penyakit 7
    daftarPenyakit[7].nama := 'Diabetes';
    daftarPenyakit[7].gejala[1] := 'sering haus';
    daftarPenyakit[7].gejala[2] := 'sering buang air kecil';
    daftarPenyakit[7].gejala[3] := 'mudah lelah';
    daftarPenyakit[7].gejala[4] := 'berat badan turun';

    // Penyakit 8
    daftarPenyakit[8].nama := 'Migrain';
    daftarPenyakit[8].gejala[1] := 'sakit kepala';
    daftarPenyakit[8].gejala[2] := 'mual';
    daftarPenyakit[8].gejala[3] := 'sensitif cahaya';

    // Penyakit 9
    daftarPenyakit[9].nama := 'Covid-19';
    daftarPenyakit[9].gejala[1] := 'demam';
    daftarPenyakit[9].gejala[2] := 'batuk';
    daftarPenyakit[9].gejala[3] := 'sesak napas';
    daftarPenyakit[9].gejala[4] := 'hilang penciuman';
    daftarPenyakit[9].gejala[5] := 'sakit kepala';

    // Penyakit 10
    daftarPenyakit[10].nama := 'Tuberkulosis';
    daftarPenyakit[10].gejala[1] := 'batuk lama';
    daftarPenyakit[10].gejala[2] := 'berkeringat malam';
    daftarPenyakit[10].gejala[3] := 'berat badan turun';
end;

procedure InputGejala;
var
    input: string;
    counter: integer;
begin
    counter := 0;
    writeln('Masukkan gejala-gejala yang Anda alami (maksimal 10, ketik "selesai" untuk berhenti):');
    repeat
        write('Gejala ', counter + 1, ': ');
        readln(input);
        if (input <> 'selesai') and (counter < 10) then
        begin
            inc(counter);
            gejalaUser[counter] := input;
        end;
    until (input = 'selesai') or (counter = 10);
    jumlahGejala := counter;
end;

function CariPenyakit: string;
var
    matchCount: array[1..10] of integer;
    hasil: string;
    k, l, j: integer;
begin
    for k := 1 to 10 do
        matchCount[k] := 0;

    // Hitung kecocokan
    for k := 1 to 10 do
        for l := 1 to jumlahGejala do
            for j := 1 to 10 do
                if (daftarPenyakit[k].gejala[j] <> '') and
                   (gejalaUser[l] = daftarPenyakit[k].gejala[j]) then
                    inc(matchCount[k]);

    // Susun hasil untuk semua penyakit yang punya kecocokan >= 1
    hasil := '';
    for k := 1 to 10 do
        if matchCount[k] > 0 then
            hasil := hasil + daftarPenyakit[k].nama + ' (cocok ' +
                     IntToStrSimple(matchCount[k]) + ' gejala)' + #13#10;

    if hasil = '' then
        CariPenyakit := 'Tidak dapat mendiagnosa penyakit berdasarkan gejala yang dimasukkan.'
    else
        CariPenyakit := 'Kemungkinan penyakit berdasarkan gejala:' + #13#10 + hasil;
end;

procedure TampilkanHasil(hasil: string);
begin
    writeln;
    writeln('Hasil Diagnosa:');
    writeln(hasil);
    writeln('Catatan: Ini hanya diagnosa sederhana. Konsultasikan dengan dokter untuk diagnosis yang akurat.');
end;

begin
    clrscr;
    InisialisasiData;
    InputGejala;
    if jumlahGejala = 0 then
        writeln('Anda tidak memasukkan gejala apapun.')
    else
        TampilkanHasil(CariPenyakit);
    readln;
end.