# longest_transcript.pl

Selects the transcript with the longest total CDS length for each gene from a GFF3 annotation file.

The script:

1. Reads mRNA and CDS features from a GFF3 file.
2. Groups transcripts according to the `Parent` attribute.
3. Calculates the total CDS length of each transcript.
4. Retains the transcript with the longest CDS for each gene.
5. Outputs the selected mRNA and CDS annotation lines as a new GFF3 file.

## Requirements

- Perl
- GFF3 annotation file
- `gffread` for extracting peptide sequences

The GFF3 file should contain:

- `mRNA` features with `ID` and `Parent`
- `CDS` features with `Parent`
- mRNA features should appear before their corresponding CDS features

## Usage
```bash
perl longest_transcript.pl input.gff3 > longest_transcript.gff3

gffread longest_isoform.gff3 \
    -g input.fa \
    -y longest_isoform.pep.fa

## Notes
This script selects transcripts according to total CDS length rather than total transcript length. It is intended for extracting one representative protein-coding transcript per gene.
The script does not retain the original `gene`, `exon`, `UTR`, or other annotation features unless they are explicitly printed by the script.
