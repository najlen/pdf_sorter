# PDF Sorter

Watches a folder for PDF's. Sorts PDF to different folders based on their text content.

PDF’s must contain text. If you they are scanned they must be OCR’ed in advanced.

The original use case is to have a scanner set up to scan and OCR files to one folder, and then let this program sort scans to a tidy directory structure.

It runs as a CLI command (bin/pdfsorter) and has a DSL to describe how things should be sorted (examples/rules.rb).
