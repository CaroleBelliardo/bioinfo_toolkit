import sys
import gzip
import statistics
import matplotlib.pyplot as plt
from Bio import SeqIO
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph
from reportlab.platypus.tables import Table, TableStyle
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch

def read_fastq(input_file):
    """
    Read a FASTQ file and return a list of SeqRecord objects.
    """
    records = []
    try:
        if input_file.endswith(".gz"):
            # Open the input file as a gzipped FASTQ file
            with gzip.open(input_file, "rt") as handle:
                records = list(SeqIO.parse(handle, "fastq"))
        else:
            # Open the input file as a plain FASTQ file
            with open(input_file, "r") as handle:
                records = list(SeqIO.parse(handle, "fastq"))
    except Exception as e:
        sys.stderr.write(f"Error: {str(e)}\n")
        sys.exit(1)
    return records

def calculate_qphred_scores(records):
    """
    Calculate Qphred scores for a list of SeqRecord objects and return a list of scores.
    """
    qphred_scores = [sum(record.letter_annotations["phred_quality"]) / len(record) for record in records]
    return qphred_scores

def write_qphred_scores(records, output_file):
    """
    Write read names and Qphred scores to an output file.
    """
    try:
        with open(output_file, "w") as out_handle:
            for record in records:
                read_name = record.id
                qphred = sum(record.letter_annotations["phred_quality"]) / len(record)
                out_handle.write(f"{read_name}\t{qphred}\n")
        print(f"Qphred scores calculated and saved to {output_file}")
    except Exception as e:
        sys.stderr.write(f"Error: {str(e)}\n")
        sys.exit(1)

def calculate_statistics(qphred_scores):
    """
    Calculate statistics (count, min, max, median, mean) for a list of Qphred scores.
    """
    num_sequences = len(qphred_scores)
    phred_min = min(qphred_scores)
    phred_max = max(qphred_scores)
    phred_median = statistics.median(qphred_scores)
    phred_mean = statistics.mean(qphred_scores)
    return num_sequences, phred_min, phred_max, phred_median, phred_mean

def generate_pdf_report(output_file, num_sequences, phred_min, phred_max, phred_median, phred_mean, sequence_lengths, qphred_scores):
    """
    Generate a PDF report with statistics and plots.
    """
    try:
        doc = SimpleDocTemplate(output_file, pagesize=letter)
        elements = []

        # Title
        styles = getSampleStyleSheet()
        elements.append(Paragraph("FASTQ Statistics", styles["Title"]))

        # Statistics table
        data = [
            ["Number of Sequences", num_sequences],
            ["Phred Min", phred_min],
            ["Phred Max", phred_max],
            ["Phred Median", phred_median],
            ["Phred Mean", phred_mean],
        ]
        table = Table(data, colWidths=[3*inch, 1*inch])
        table.setStyle(TableStyle([('BACKGROUND', (0, 0), (-1, 0), colors.grey),
                                   ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
                                   ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                                   ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                                   ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
                                   ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
                                   ('GRID', (0, 0), (-1, -1), 1, colors.black)])
        )
        elements.append(table)

        # Plot sequence length distribution
        plt.figure(figsize=(6, 4))
        plt.hist(sequence_lengths, bins=20, color='skyblue', edgecolor='black')
        plt.title("Sequence Length Distribution")
        plt.xlabel("Sequence Length")
        plt.ylabel("Count")
        sequence_length_plot = "sequence_length_distribution.png"
        plt.savefig(sequence_length_plot)
        plt.close()
        elements.append(Paragraph("<br/><br/><br/>", styles["Normal"]))
        elements.append(Paragraph("Sequence Length Distribution:", styles["Heading3"]))
        elements.append(Paragraph("<br/>", styles["Normal"]))
        elements.append(plt.Image(sequence_length_plot, width=6*inch, height=4*inch))

        # Plot Qphred score distribution
        plt.figure(figsize=(6, 4))
        plt.hist(qphred_scores, bins=20, color='lightcoral', edgecolor='black')
        plt.title("Qphred Score Distribution")
        plt.xlabel("Qphred Score")
        plt.ylabel("Count")
        qphred_plot = "qphred_score_distribution.png"
        plt.savefig(qphred_plot)
        plt.close()
        elements.append(Paragraph("<br/><br/><br/>", styles["Normal"]))
        elements.append(Paragraph("Qphred Score Distribution:", styles["Heading3"]))
        elements.append(Paragraph("<br/>", styles["Normal"]))
        elements.append(plt.Image(qphred_plot, width=6*inch, height=4*inch))

        # Plot Sequence Length vs. Qphred Score
        plt.figure(figsize=(6, 4))
        plt.scatter(sequence_lengths, qphred_scores, color='lightgreen', marker='.')
        plt.title("Sequence Length vs. Qphred Score")
        plt.xlabel("Sequence Length")
        plt.ylabel("Qphred Score")
        sequence_qphred_plot = "sequence_qphred_plot.png"
        plt.savefig(sequence_qphred_plot)
        plt.close()
        elements.append(Paragraph("<br/><br/><br/>", styles["Normal"]))
        elements.append(Paragraph("Sequence Length vs. Qphred Score:", styles["Heading3"]))
        elements.append(Paragraph("<br/>", styles["Normal"]))
        elements.append(plt.Image(sequence_qphred_plot, width=6*inch, height=4*inch))

        doc.build(elements)

        print(f"Qphred scores calculated and saved to {output_file}")
        print(f"Statistics and plots saved to {output_file}")

    except Exception as e:
        sys.stderr.write(f"Error: {str(e)}\n")
        sys.exit(1)

