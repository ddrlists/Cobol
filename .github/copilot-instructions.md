# Copilot Instructions for COBOL Projects

## Project Overview
This repository contains COBOL programs focused on file processing and data manipulation. The project serves as a template-based foundation for sequential file I/O operations.

## Architecture & Key Files

### `Test` - File Reading Template
The primary template demonstrating COBOL file handling patterns:
- **IDENTIFICATION DIVISION**: Program metadata (PROGRAM-ID, AUTHOR, DATE-WRITTEN)
- **ENVIRONMENT DIVISION**: Defines file mappings (INPUT-FILE → input.dat) and FILE-CONTROL
- **DATA DIVISION**: Record layout definitions (FD section) and working variables (WORKING-STORAGE)
- **PROCEDURE DIVISION**: Structured processing flow with modular paragraphs (000-MAIN-LOGIC, 100-INITIALIZE, 200-PROCESS-FILE, etc.)

## COBOL Development Patterns

### File I/O Pattern
```cobol
- OPEN INPUT/OUTPUT file
- Check FILE-STATUS for errors ("00" = OK, "10" = EOF)
- Use READ with AT END and NOT AT END clauses
- CLOSE file on completion
```

### Control Flow Convention
- **Paragraph naming**: Numbered (e.g., 100-INITIALIZE, 150-READ-RECORD) for execution order clarity
- **EOF handling**: Use 88-level condition names (END-OF-FILE) set via flags (WS-EOF-FLAG)
- **PERFORM UNTIL**: Standard loop for sequential file processing until EOF
- **Nested PERFORM**: Modular paragraph structure enables code reuse and testing

### Data Division Structure
- **01-level records**: Define logical record structures (INPUT-RECORD)
- **05-level fields**: Break records into typed fields (PIC 9, PIC X, PIC S9V99)
- **88-level conditions**: Create readable boolean flags (FS-OK, FS-EOF, END-OF-FILE)
- **FILLER**: Pad record definitions with unused space

## Common Tasks & Commands

### Adding New COBOL Programs
1. Copy `Test` as template to new filename
2. Update IDENTIFICATION DIVISION (PROGRAM-ID, AUTHOR)
3. Modify ENVIRONMENT DIVISION file mappings (SELECT...ASSIGN)
4. Update DATA DIVISION with proper record layout
5. Implement business logic in 250-HANDLE-DATA paragraph

### File Status Codes
- `"00"`: Successful operation
- `"10"`: End-of-file reached (used in AT END clause)
- Other codes: Error conditions (reference COBOL documentation)

### Compilation & Execution
- Use standard COBOL compiler (e.g., GnuCOBOL with `cobc`)
- Input files referenced in ASSIGN TO must exist at runtime
- FILE STATUS variables capture operation success/failure

## Project-Specific Conventions

1. **Mandatory FILE STATUS checking**: Always assign FILE STATUS in SELECT clauses
2. **EOF flag pattern**: Use 88-level conditions paired with 01-level flags for clarity
3. **Modular paragraphs**: Organize code in 100-series, 200-series increments for logical grouping
4. **Record processing loop**: Standard PERFORM UNTIL with READ...AT END inside loop

## Extension Points

- **250-HANDLE-DATA**: Business logic placeholder for record processing
- **Input file mapping**: Modify ASSIGN TO for different data sources
- **Record layout**: Extend 01-level structures for additional fields (e.g., IN-DEPARTMENT PIC X(20))
