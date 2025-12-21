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
        with daftarPenyakit[i] do
            for j := 1 to 10 do
                gejala[j] := '';

    // Penyakit 1
    with daftarPenyakit[1] do begin
        nama := 'Flu';
        gejala[1] := 'demam';
        gejala[2] := 'batuk';
        gejala[3] := 'pilek';
        gejala[4] := 'sakit kepala';
    end;

    // Penyakit 2
    with daftarPenyakit[2] do begin
        nama := 'Demam Berdarah';
        gejala[1] := 'demam tinggi';
        gejala[2] := 'nyeri sendi';
        gejala[3] := 'ruam kulit';
        gejala[4] := 'sakit kepala';
        gejala[5] := 'mual';
    end;

    // Penyakit 3
    with daftarPenyakit[3] do begin
        nama := 'Maag';
        gejala[1] := 'nyeri perut';
        gejala[2] := 'mual';
        gejala[3] := 'perut kembung';
        gejala[4] := 'asam lambung naik';
    end;

    // Penyakit 4
    with daftarPenyakit[4] do begin
        nama := 'Tifus';
        gejala[1] := 'demam';
        gejala[2] := 'lemas';
        gejala[3] := 'mual';
        gejala[4] := 'sakit perut';
        gejala[5] := 'diare';
    end;

    // Penyakit 5
    with daftarPenyakit[5] do begin
        nama := 'Asma';
        gejala[1] := 'sesak napas';
        gejala[2] := 'batuk';
        gejala[3] := 'dada terasa berat';
    end;

    // Penyakit 6
    with daftarPenyakit[6] do begin
        nama := 'Hipertensi';
        gejala[1] := 'pusing';
        gejala[2] := 'penglihatan kabur';
        gejala[3] := 'mudah lelah';
    end;

    // Penyakit 7
    with daftarPenyakit[7] do begin
        nama := 'Diabetes';
        gejala[1] := 'sering haus';
        gejala[2] := 'sering buang air kecil';
        gejala[3] := 'mudah lelah';
        gejala[4] := 'berat badan turun';
    end;

    // Penyakit 8
    with daftarPenyakit[8] do begin
        nama := 'Migrain';
        gejala[1] := 'sakit kepala';
        gejala[2] := 'mual';
        gejala[3] := 'sensitif cahaya';
    end;

    // Penyakit 9
    with daftarPenyakit[9] do begin
        nama := 'Covid-19';
        gejala[1] := 'demam';
        gejala[2] := 'batuk';
        gejala[3] := 'sesak napas';
        gejala[4] := 'hilang penciuman';
        gejala[5] := 'sakit kepala';
    end;

    // Penyakit 10
    with daftarPenyakit[10] do begin
        nama := 'Tuberkulosis';
        gejala[1] := 'batuk lama';
        gejala[2] := 'berkeringat malam';
        gejala[3] := 'berat badan turun';
    end;
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
                with daftarPenyakit[k] do
                    if (gejala[j] <> '') and (gejalaUser[l] = gejala[j]) then
                        inc(matchCount[k]);

    // Susun hasil untuk semua penyakit yang punya kecocokan >= 1
    hasil := '';
    for k := 1 to 10 do
        if matchCount[k] > 0 then
            with daftarPenyakit[k] do
                hasil := hasil + nama + ' (cocok ' + IntToStrSimple(matchCount[k]) + ' gejala)' + #13#10;

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
