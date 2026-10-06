# Walkthrough - SIUF Cooperazione Applicativa Error Handling

We have successfully implemented client-side pre-send validation and comprehensive server-returned error mapping/classification for the SIUF Extra Obbligo (EOB) integration.

## Changes Completed

### 1. Types Extension
Modified [SIUF.CooperazioneApplicativa.Types.pas](file:///c:/Users/Luca/Desktop/Antigravity/Gesty/Cooperazione%20Applicativa/src/SIUF.CooperazioneApplicativa.Types.pas):
- Introduced the `TSiufErroreTipo` enum to represent each classification of error.
- Introduced the `TSiufDettaglioErrore` record to hold parsed context about the error (Student, Section, Docente, Course, Date, and Original Message).
- Extended `TSiufEsito` with `Tipo` and `DettaglioErrore`.
- Added helper functions to `TSiufPresenza` for parsing and checking durations:
  - `DurataLezioneMinuti`
  - `OrePresenzaMinuti`
  - `OreAssenzaMinuti`
  - `OreAssenzaGiustificataMinuti`

### 2. Client-Side Validator
Created [SIUF.CooperazioneApplicativa.Validator.pas](file:///c:/Users/Luca/Desktop/Antigravity/Gesty/Cooperazione%20Applicativa/src/SIUF.CooperazioneApplicativa.Validator.pas):
- Implemented `TSiufValidator.Valida` checking:
  - Required header fields (user tax code, section ID, list not empty).
  - Header date interval limits (start date <= end date, interval <= 3 calendar days).
  - Student identity validation (must have tax code or both surname and name).
  - Lesson date range check (must fall within start and end dates).
  - Lesson duration checks (end time must be after start time).
  - Justified absence check (must be exactly `"0"`).
  - Hour balance checks (sum of presence + absence + justified absence minutes must equal the lesson duration in minutes).

### 3. Server Error Handling and Extraction
Modified [SIUF.CooperazioneApplicativa.Client.pas](file:///c:/Users/Luca/Desktop/Antigravity/Gesty/Cooperazione%20Applicativa/src/SIUF.CooperazioneApplicativa.Client.pas):
- Implemented `ClassificaErrore` to match localized server messages to standard error types.
- Implemented `ParseDettaglioErrore` with a case-insensitive `ExtractBetween` utility to isolate variables (such as student names/tax codes or section codes) from localized error messages, populating `TSiufDettaglioErrore`.
- Updated `ParseEsito` to perform classification and detail extraction when `esitoCaricamento` is false.

### 4. Example and Exceptions
Modified [SIUF.CooperazioneApplicativa.Esempio.pas](file:///c:/Users/Luca/Desktop/Antigravity/Gesty/Cooperazione%20Applicativa/src/SIUF.CooperazioneApplicativa.Esempio.pas):
- Created `ESiufValidazione` exception class which reports all validation warnings.
- Integrated validation inside `InviaPresenzeSiuf` to block transmission and raise `ESiufValidazione` if violations are found.

## Verification

We verified the classification and parsing logic using a test script running against the Excel error sheet (`Lista possibili errori EOB cooperazione applicativa.xlsx`), achieving 100% correct classification and contextual entity extraction (e.g. extracting Student code, Section code, or Lesson date).
