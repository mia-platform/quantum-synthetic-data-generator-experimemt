/// # Quantum Book Data Generator
/// This Q# program generates synthetic book data using quantum superposition and entanglement
/// based on patterns from existing book data in JSON format.

import Std.Arrays.*;
import Std.Canon.*;
import Std.Convert.*;
import Std.Intrinsic.*;
import Std.Math.*;
import Std.Measurement.*;
import Std.Random.*;

/// # Summary
/// Represents a synthetic book with all required fields
struct BookSample {
    Id : String,
    Title : String,
    Isbn : String,
    PublishedYear : Int,
    Genre : String,
    Description : String,
    State : String,
    CreatorId : String,
    UpdaterId : String
}

/// # Summary
/// Main entry point that generates synthetic book data samples
@EntryPoint()
operation GenerateQuantumBookData() : BookSample[] {
    Message("Starting Quantum Book Data Generation...");
    
    let sampleSize = 50; // Number of books to generate
    mutable books = [];
    
    for i in 0..sampleSize-1 {
        let book = GenerateSingleBook(i);
        set books += [book];
        
        if i % 10 == 0 or i == sampleSize - 1 {
            Message($"Generated {i + 1} books...");
        }
    }
    
    Message($"Successfully generated {Length(books)} synthetic books using quantum techniques!");
    return books;
}

/// # Summary
/// Generates a single synthetic book using quantum operations
operation GenerateSingleBook(seed : Int) : BookSample {
    // Generate publication year using quantum superposition (1900-2025)
    let publishedYear = GenerateQuantumPublicationYear();
    
    // Generate genre using quantum categorical distribution
    let genre = GenerateQuantumGenre();
    
    // Generate title based on genre using quantum correlation
    let title = GenerateQuantumTitle(genre);
    
    // Generate ISBN using quantum randomness
    let isbn = GenerateQuantumISBN();
    
    // Generate description correlated with genre
    let description = GenerateQuantumDescription(genre);
    
    // Generate other fields
    let id = GenerateQuantumId(seed);
    let state = GenerateQuantumState();
    let creatorId = GenerateQuantumCreatorId();
    let updaterId = GenerateQuantumUpdaterId();
    
    return BookSample(id, title, isbn, publishedYear, genre, description, state, creatorId, updaterId);
}

/// # Summary
/// Generates publication year using quantum superposition biased toward recent years
operation GenerateQuantumPublicationYear() : Int {
    use qubits = Qubit[7]; // 7 qubits for 0-127 range
    
    // Create superposition with bias toward recent years
    for i in 0..6 {
        H(qubits[i]);
    }
    
    // Add bias toward modern publications (1950-2025)
    Controlled Ry([qubits[0]], (PI() / 4.0, qubits[5]));
    Controlled Ry([qubits[1]], (PI() / 6.0, qubits[6]));
    
    // Add cross-correlations for realistic distribution
    CNOT(qubits[2], qubits[4]);
    CNOT(qubits[3], qubits[5]);
    
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // Map to publication year range (1900-2025)
    let year = 1900 + (rawValue % 126);
    
    ResetAll(qubits);
    return year;
}

/// # Summary
/// Generates book genre using quantum categorical distribution
operation GenerateQuantumGenre() : String {
    use qubits = Qubit[3]; // 3 qubits for 8 possible genres
    
    // Create weighted superposition for common book genres
    H(qubits[0]);
    H(qubits[1]);
    
    // Apply rotations for genre probability distribution
    Ry(PI() / 3.0, qubits[2]);
    
    // Add entanglement for realistic genre clustering
    CNOT(qubits[0], qubits[2]);
    Controlled Ry([qubits[1]], (PI() / 5.0, qubits[2]));
    
    let results = MeasureEachZ(qubits);
    let genreIndex = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    if genreIndex == 0 {
        return "Fiction";
    } elif genreIndex == 1 {
        return "Fantasy";
    } elif genreIndex == 2 {
        return "Science Fiction";
    } elif genreIndex == 3 {
        return "Mystery";
    } elif genreIndex == 4 {
        return "Romance";
    } elif genreIndex == 5 {
        return "Thriller";
    } elif genreIndex == 6 {
        return "Historical";
    } else {
        return "Biography";
    }
}

/// # Summary
/// Generates book title correlated with genre using quantum entanglement
operation GenerateQuantumTitle(genre : String) : String {
    use qubits = Qubit[4]; // 4 qubits for title variation
    
    // Create base superposition
    for i in 0..3 {
        H(qubits[i]);
    }
    
    // Apply genre-specific bias using quantum rotations
    let genreIndex = GetGenreIndex(genre);
    let biasAngle = IntAsDouble(genreIndex) * PI() / 8.0;
    
    for i in 0..3 {
        Ry(biasAngle / IntAsDouble(i + 1), qubits[i]);
    }
    
    // Add entanglement for title coherence
    CNOT(qubits[0], qubits[2]);
    CNOT(qubits[1], qubits[3]);
    
    let results = MeasureEachZ(qubits);
    let titleIndex = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    return GenerateTitleByGenreAndIndex(genre, titleIndex);
}

/// # Summary
/// Helper function to get numeric index for genre
function GetGenreIndex(genre : String) : Int {
    if genre == "Fiction" { return 0; }
    elif genre == "Fantasy" { return 1; }
    elif genre == "Science Fiction" { return 2; }
    elif genre == "Mystery" { return 3; }
    elif genre == "Romance" { return 4; }
    elif genre == "Thriller" { return 5; }
    elif genre == "Historical" { return 6; }
    else { return 7; } // Biography
}

/// # Summary
/// Generate title based on genre and quantum index
function GenerateTitleByGenreAndIndex(genre : String, index : Int) : String {
    let modIndex = index % 4; // Use modulo to cycle through title patterns
    
    if genre == "Fiction" {
        if modIndex == 0 { return "The Silent Echo"; }
        elif modIndex == 1 { return "Beneath the Surface"; }
        elif modIndex == 2 { return "The Last Chapter"; }
        else { return "Whispers in Time"; }
    } elif genre == "Fantasy" {
        if modIndex == 0 { return "The Crystal Throne"; }
        elif modIndex == 1 { return "Dragons of the Northern Realm"; }
        elif modIndex == 2 { return "The Enchanted Forest"; }
        else { return "Sword of Destiny"; }
    } elif genre == "Science Fiction" {
        if modIndex == 0 { return "Quantum Horizon"; }
        elif modIndex == 1 { return "The Mars Chronicles"; }
        elif modIndex == 2 { return "Beyond the Stars"; }
        else { return "Cyber Dreams"; }
    } elif genre == "Mystery" {
        if modIndex == 0 { return "The Missing Key"; }
        elif modIndex == 1 { return "Death in the Library"; }
        elif modIndex == 2 { return "The Secret Code"; }
        else { return "Midnight Investigation"; }
    } elif genre == "Romance" {
        if modIndex == 0 { return "Love in Paris"; }
        elif modIndex == 1 { return "The Heart's Journey"; }
        elif modIndex == 2 { return "Summer Romance"; }
        else { return "Forever Yours"; }
    } elif genre == "Thriller" {
        if modIndex == 0 { return "The Chase"; }
        elif modIndex == 1 { return "Deadly Secrets"; }
        elif modIndex == 2 { return "Race Against Time"; }
        else { return "The Fugitive"; }
    } elif genre == "Historical" {
        if modIndex == 0 { return "The War Chronicles"; }
        elif modIndex == 1 { return "Empire's End"; }
        elif modIndex == 2 { return "Medieval Tales"; }
        else { return "The Revolution"; }
    } else { // Biography
        if modIndex == 0 { return "A Life Remembered"; }
        elif modIndex == 1 { return "The Journey of Greatness"; }
        elif modIndex == 2 { return "Against All Odds"; }
        else { return "The Making of a Legend"; }
    }
}

/// # Summary
/// Generates ISBN using quantum randomness
operation GenerateQuantumISBN() : String {
    use qubits = Qubit[8]; // 8 qubits for ISBN generation
    
    // Create superposition
    ApplyToEach(H, qubits);
    
    // Add some quantum correlations
    for i in 0..3 {
        CNOT(qubits[i], qubits[i + 4]);
    }
    
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    // Generate realistic ISBN-13 format: 978 + 10 digits
    let baseNumber = 1000000000 + (rawValue * 31415927) % 9000000000; // Ensure 10 digits
    return $"978{baseNumber}";
}

/// # Summary
/// Generates description correlated with genre
operation GenerateQuantumDescription(genre : String) : String {
    use qubits = Qubit[3];
    
    // Create superposition biased by genre
    let genreIndex = GetGenreIndex(genre);
    let angle = IntAsDouble(genreIndex) * PI() / 8.0;
    
    Ry(angle, qubits[0]);
    H(qubits[1]);
    Controlled Ry([qubits[0]], (PI() / 4.0, qubits[2]));
    
    let results = MeasureEachZ(qubits);
    let descIndex = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    return GenerateDescriptionByGenre(genre, descIndex % 3);
}

/// # Summary
/// Generate description based on genre and index
function GenerateDescriptionByGenre(genre : String, index : Int) : String {
    if genre == "Fiction" {
        if index == 0 { return "A captivating tale of human emotion and complex relationships."; }
        elif index == 1 { return "An exploration of life's deepest mysteries through compelling characters."; }
        else { return "A thought-provoking narrative that challenges conventional wisdom."; }
    } elif genre == "Fantasy" {
        if index == 0 { return "An epic adventure in a world of magic and mythical creatures."; }
        elif index == 1 { return "A journey through realms where ancient powers shape destiny."; }
        else { return "A tale of heroes and villains in a land beyond imagination."; }
    } elif genre == "Science Fiction" {
        if index == 0 { return "A futuristic vision of humanity's technological advancement."; }
        elif index == 1 { return "An exploration of space, time, and the possibilities of tomorrow."; }
        else { return "A thrilling adventure across galaxies and parallel dimensions."; }
    } elif genre == "Mystery" {
        if index == 0 { return "A puzzling case that challenges the sharpest detective minds."; }
        elif index == 1 { return "Secrets unfold in this gripping tale of crime and investigation."; }
        else { return "A labyrinth of clues leading to an unexpected conclusion."; }
    } elif genre == "Romance" {
        if index == 0 { return "A heartwarming story of love conquering all obstacles."; }
        elif index == 1 { return "Passion and romance bloom in this enchanting love story."; }
        else { return "Two souls find each other against all odds in this touching tale."; }
    } elif genre == "Thriller" {
        if index == 0 { return "A high-stakes adventure that will keep you on the edge."; }
        elif index == 1 { return "Suspense and danger lurk around every corner in this thrilling tale."; }
        else { return "A pulse-pounding story of survival and determination."; }
    } elif genre == "Historical" {
        if index == 0 { return "A vivid portrayal of life in a bygone era."; }
        elif index == 1 { return "History comes alive in this meticulously researched narrative."; }
        else { return "A journey through time revealing the struggles and triumphs of the past."; }
    } else { // Biography
        if index == 0 { return "The inspiring life story of a remarkable individual."; }
        elif index == 1 { return "A detailed account of achievements that changed the world."; }
        else { return "An intimate portrait of greatness through adversity."; }
    }
}

/// # Summary
/// Generates quantum ID using hexadecimal-like pattern
operation GenerateQuantumId(seed : Int) : String {
    use qubits = Qubit[6];
    
    // Initialize with seed-based pattern
    let seedMod = seed % 4;
    for i in 0..seedMod {
        if i < Length(qubits) {
            X(qubits[i]);
        }
    }
    
    // Apply quantum evolution
    ApplyToEach(H, qubits);
    for i in 0..4 {
        CNOT(qubits[i], qubits[(i + 1) % 6]);
    }
    
    let results = MeasureEachZ(qubits);
    ResetAll(qubits);
    
    // Convert to hex-like ID
    mutable idString = "";
    for result in results {
        let digit = result == One ? 1 | 0;
        set idString += $"{digit}";
    }
    
    return $"68f226aa98254bc1f6d51c{idString}";
}

/// # Summary
/// Generates quantum state (PUBLIC/PRIVATE/DRAFT)
operation GenerateQuantumState() : String {
    use qubit = Qubit();
    
    // Bias toward PUBLIC state (80% probability)
    Ry(2.0 * ArcSin(Sqrt(0.2)), qubit);
    
    let result = MResetZ(qubit);
    
    if result == Zero {
        return "PUBLIC";
    } else {
        // Further subdivision between PRIVATE and DRAFT
        use subQubit = Qubit();
        H(subQubit);
        let subResult = MResetZ(subQubit);
        return subResult == Zero ? "PRIVATE" | "DRAFT";
    }
}

/// # Summary
/// Generates creator ID using quantum selection
operation GenerateQuantumCreatorId() : String {
    use qubits = Qubit[2];
    
    ApplyToEach(H, qubits);
    let results = MeasureEachZ(qubits);
    let index = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    if index == 0 { return "giulio"; }
    elif index == 1 { return "stefano"; }
    elif index == 2 { return "alice"; }
    else { return "marco"; }
}

/// # Summary
/// Generates updater ID using quantum selection
operation GenerateQuantumUpdaterId() : String {
    use qubits = Qubit[2];
    
    ApplyToEach(H, qubits);
    let results = MeasureEachZ(qubits);
    let index = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    if index == 0 { return "stefano"; }
    elif index == 1 { return "giulio"; }
    elif index == 2 { return "alice"; }
    else { return "marco"; }
}