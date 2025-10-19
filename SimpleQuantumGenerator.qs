/// # Simple Quantum Data Generator (Tutorial Example)
/// This is a simplified introduction to quantum data generation concepts using basic
/// quantum superposition and entanglement techniques for generic data types.
/// 
/// Learning Path:
/// 1. Start here for basic quantum data generation concepts
/// 2. Progress to QuantumDataGenerator.qs for advanced techniques  
/// 3. Apply to real use cases with QuantumBookGenerator.qs
///
/// This example demonstrates fundamental quantum operations for synthetic data creation
/// with simple data types (age, income, categories) before moving to domain-specific applications.

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
/// Simple tutorial entry point for learning quantum synthetic data generation
/// Demonstrates fundamental concepts with simple, easy-to-understand examples
@EntryPoint()
operation SimpleQuantumDataGenerator() : DataSample[] {
    Message("=== Simple Quantum Data Generator (Tutorial) ===");
    Message("This example demonstrates fundamental quantum data generation concepts.");
    Message("For advanced techniques, run QuantumDataGenerator.qs");
    Message("For real-world applications, see QuantumBookGenerator.qs");
    Message("");
    
    let sampleSize = 10; // Small sample size for tutorial clarity
    mutable samples = [];
    
    Message("Generating samples using basic quantum techniques...");
    
    for i in 0..sampleSize-1 {
        let sample = GenerateSingleSample(i);
        set samples += [sample];
        Message($"Sample {i + 1}: Age={sample.Age}, Income=${sample.Income}, Category={sample.Category}, Flag={sample.BinaryFlag}");
    }
    
    Message("");
    Message($"✓ Successfully generated {Length(samples)} samples using basic quantum operations!");
    Message("🎓 You've completed the basic tutorial. Ready for advanced techniques?");
    return samples;
}

/// # Summary
/// Generates a single synthetic data sample using basic quantum operations
/// This demonstrates the core concepts of quantum data generation in simple steps
operation GenerateSingleSample(seed : Int) : DataSample {
    // 🎓 Tutorial Step 1: Generate age using quantum superposition (18-80 years)
    let age = GenerateQuantumAge();
    
    // 🎓 Tutorial Step 2: Generate income with entanglement to age (correlated feature)
    let income = GenerateQuantumIncomeCorrelated(age);
    
    // 🎓 Tutorial Step 3: Generate categorical data using quantum superposition
    let category = GenerateQuantumCategory();
    
    // 🎓 Tutorial Step 4: Generate binary flag with quantum probability
    let binaryFlag = GenerateQuantumBinaryFlag();
    
    return DataSample(age, income, category, binaryFlag);
}

/// # Summary
/// 🎓 TUTORIAL: Basic quantum age generation using superposition
/// Demonstrates how quantum superposition creates probabilistic distributions
/// This is the foundation concept for all quantum data generation
operation GenerateQuantumAge() : Int {
    use qubits = Qubit[6]; // 6 qubits can represent 0-63 (tutorial: start simple)
    
    // 🎓 Step 1: Create superposition states (qubits in |0⟩+|1⟩ state)
    H(qubits[0]);
    H(qubits[1]);
    H(qubits[2]);
    
    // 🎓 Step 2: Add bias toward middle values using controlled rotations
    // This creates a more realistic age distribution (not completely random)
    Controlled Ry([qubits[0]], (PI() / 3.0, qubits[3]));
    Controlled Ry([qubits[1]], (PI() / 4.0, qubits[4]));
    Controlled Ry([qubits[2]], (PI() / 6.0, qubits[5]));
    
    // 🎓 Step 3: Measure quantum states to get classical result
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // 🎓 Step 4: Map quantum measurement to realistic age range 18-80
    let age = 18 + (rawValue % 63);
    
    ResetAll(qubits);
    return age;
}

/// # Summary
/// 🎓 TUTORIAL: Quantum entanglement for correlated data generation
/// Demonstrates how quantum entanglement creates natural correlations between features
/// This is a key advantage of quantum data generation over classical random methods
operation GenerateQuantumIncomeCorrelated(age : Int) : Int {
    use qubits = Qubit[8]; // 8 qubits for income range (tutorial: manageable size)
    
    // 🎓 Step 1: Create base superposition for randomness
    for i in 0..3 {
        H(qubits[i]);
    }
    
    // 🎓 Step 2: Create correlation based on age input
    // This demonstrates how quantum systems can naturally encode relationships
    let ageNormalized = IntAsDouble(age - 18) / 62.0; // Normalize age to 0-1
    let correlationAngle = ageNormalized * PI() / 2.0;
    
    // 🎓 Step 3: Apply age-correlated rotations (older age → different income distribution)
    Ry(correlationAngle, qubits[4]);
    Ry(correlationAngle * 0.8, qubits[5]);
    
    // 🎓 Step 4: Create entanglement between age-influenced qubits and income qubits
    // This is where the "quantum magic" happens - natural correlation!
    for i in 0..3 {
        CNOT(qubits[4], qubits[i]);
    }
    
    // 🎓 Step 5: Measure entangled state to get correlated result
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // 🎓 Step 6: Map to realistic income range with age correlation
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