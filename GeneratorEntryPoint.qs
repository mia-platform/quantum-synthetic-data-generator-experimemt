/// # Quantum Synthetic Data Generator
/// This Q# program generates synthetic data using quantum superposition and entanglement
/// to create realistic data distributions based on a JSON configuration.

import Std.Arrays.*;
import Std.Canon.*;
import Std.Convert.*;
import Std.Intrinsic.*;
import Std.Math.*;
import Std.Measurement.*;
import Std.Random.*;

/// # Summary
/// Represents a synthetic data sample with multiple features
struct DataSample {
    Age : Int,
    Income : Int,
    Category : String,
    BinaryFlag : Bool
}

/// # Summary
/// Main entry point that generates synthetic data samples
@EntryPoint()
operation GenerateQuantumSyntheticData() : DataSample[] {
    Message("Starting Quantum Synthetic Data Generation...");
    
    let sampleSize = 10; // Number of samples to generate
    mutable samples = [];
    
    for i in 0..sampleSize-1 {
        let sample = GenerateSingleSample(i);
        set samples += [sample];
        Message($"Generated sample {i + 1}: Age={sample.Age}, Income={sample.Income}, Category={sample.Category}, Flag={sample.BinaryFlag}");
    }
    
    Message($"Successfully generated {Length(samples)} synthetic data samples using quantum techniques!");
    return samples;
}

/// # Summary
/// Generates a single synthetic data sample using quantum operations
operation GenerateSingleSample(seed : Int) : DataSample {
    // Generate age using quantum superposition (18-80 years)
    let age = GenerateQuantumAge();
    
    // Generate income with entanglement to age (correlated feature)
    let income = GenerateQuantumIncomeCorrelated(age);
    
    // Generate categorical data using quantum superposition
    let category = GenerateQuantumCategory();
    
    // Generate binary flag with quantum probability
    let binaryFlag = GenerateQuantumBinaryFlag();
    
    return DataSample(age, income, category, binaryFlag);
}

/// # Summary
/// Generates age using quantum superposition and measurement
/// Simulates a normal distribution around age 40-50
operation GenerateQuantumAge() : Int {
    use qubits = Qubit[6]; // 6 qubits can represent 0-63
    
    // Create superposition states biased toward middle ages
    H(qubits[0]);
    H(qubits[1]);
    H(qubits[2]);
    
    // Add bias toward middle values using controlled rotations
    Controlled Ry([qubits[0]], (PI() / 3.0, qubits[3]));
    Controlled Ry([qubits[1]], (PI() / 4.0, qubits[4]));
    Controlled Ry([qubits[2]], (PI() / 6.0, qubits[5]));
    
    // Measure and convert to age range
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // Map to age range 18-80
    let age = 18 + (rawValue % 63);
    
    ResetAll(qubits);
    return age;
}

/// # Summary
/// Generates income correlated with age using quantum entanglement
operation GenerateQuantumIncomeCorrelated(age : Int) : Int {
    use qubits = Qubit[8]; // 8 qubits for income range
    
    // Create base superposition
    for i in 0..3 {
        H(qubits[i]);
    }
    
    // Create entanglement based on age to simulate correlation
    let ageNormalized = IntAsDouble(age - 18) / 62.0; // Normalize age to 0-1
    let correlationAngle = ageNormalized * PI() / 2.0;
    
    // Apply age-correlated rotations
    Ry(correlationAngle, qubits[4]);
    Ry(correlationAngle * 0.8, qubits[5]);
    
    // Add entanglement between age-influenced qubits and income qubits
    for i in 0..3 {
        CNOT(qubits[4], qubits[i]);
    }
    
    // Measure and convert to income
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // Map to income range 20,000-150,000 with age correlation
    let baseIncome = 20000 + (rawValue % 130000);
    let ageBonus = IntAsDouble(age - 18) * 500.0; // Older people tend to earn more
    let income = baseIncome + Truncate(ageBonus);
    
    ResetAll(qubits);
    return income;
}

/// # Summary
/// Generates categorical data using quantum superposition with weighted probabilities
operation GenerateQuantumCategory() : String {
    use qubits = Qubit[2]; // 2 qubits for 4 categories
    
    // Create weighted superposition for categories A, B, C, D
    // Probabilities: A=0.4, B=0.3, C=0.2, D=0.1
    
    // Apply rotations to create desired probability distribution
    Ry(2.0 * ArcSin(Sqrt(0.6)), qubits[0]); // P(|1⟩) = 0.6 for first qubit
    
    // Conditional rotation on second qubit
    // If first qubit is |0⟩: rotate to get A vs B (0.4/0.6 vs 0.2/0.6)
    // If first qubit is |1⟩: rotate to get C vs D (0.2/0.4 vs 0.2/0.4)
    Controlled Ry([qubits[0]], (2.0 * ArcSin(Sqrt(0.5)), qubits[1]));
    
    within {
        X(qubits[0]);
    } apply {
        Controlled Ry([qubits[0]], (2.0 * ArcSin(Sqrt(0.4/0.6)), qubits[1]));
    }
    
    let results = MeasureEachZ(qubits);
    let categoryIndex = ResultArrayAsInt(results);
    
    ResetAll(qubits);
    
    if categoryIndex == 0 {
        return "A";
    } elif categoryIndex == 1 {
        return "B";
    } elif categoryIndex == 2 {
        return "C";
    } else {
        return "D";
    }
}

/// # Summary
/// Generates binary flag with 70% probability of being true
operation GenerateQuantumBinaryFlag() : Bool {
    use qubit = Qubit();
    
    // Rotate to create 70% probability of measuring |1⟩
    let angle = 2.0 * ArcSin(Sqrt(0.7));
    Ry(angle, qubit);
    
    let result = MResetZ(qubit);
    return result == One;
}

/// # Summary
/// Demonstrates quantum noise injection for data augmentation
operation AddQuantumNoise(originalValue : Int, noiseLevel : Double) : Int {
    use qubit = Qubit();
    
    // Apply rotation based on noise level
    Ry(noiseLevel * PI(), qubit);
    
    let result = MResetZ(qubit);
    let noise = if result == One { 1 } else { -1 };
    
    return originalValue + noise;
}

/// # Summary
/// Creates quantum entanglement between multiple features
operation CreateFeatureEntanglement() : (Int, Int) {
    use qubits = Qubit[4];
    
    // Create entangled state between two features
    H(qubits[0]);
    H(qubits[1]);
    
    // Entangle first feature qubits
    CNOT(qubits[0], qubits[2]);
    
    // Entangle second feature qubits  
    CNOT(qubits[1], qubits[3]);
    
    // Cross-entangle features
    CNOT(qubits[0], qubits[3]);
    
    let results = MeasureEachZ(qubits);
    let feature1 = ResultArrayAsInt([results[0], results[2]]);
    let feature2 = ResultArrayAsInt([results[1], results[3]]);
    
    ResetAll(qubits);
    return (feature1, feature2);
}