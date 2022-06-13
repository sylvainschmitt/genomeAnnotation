wget https://v100.orthodb.org/download/odb10_plants_fasta.tar.gz
tar xvf odb10_arthropoda_fasta.tar.gz
cat plants/Rawdata/* > plants_proteins.fasta
rm -r plants
wget https://www.girinst.org/protected/repbase_extract.php?division=Viridiplantae&customdivision=&rank=&type=&autonomous=1&nonautonomous=1&simple=1&format=FASTA&full=true&sa=Download
