/// # Advanced Quantum Synthetic Data Generator
/// This Q# program demonstrates advanced quantum techniques for synthetic data generation
/// including quantum walks, variational circuits, and advanced probability distributions.

import Std.Arrays.*;
import Std.Canon.*;
import Std.Convert.*;
import Std.Intrinsic.*;
import Std.Math.*;
import Std.Measurement.*;
import Std.Random.*;

/// # Summary
/// Configuration structure for data generation
struct DataConfig {
    SampleSize : Int,
    UseEntanglement : Bool,
    NoiseLevel : Double
}

/// # Summary
/// Enhanced data sample with quantum fingerprint
struct QuantumDataSample {
    Id : Int,
    Age : Int,
    Income : Int,
    Category : String,
    BinaryFlag : Bool,
    QuantumFingerprint : Int[] // Unique quantum signature
}

/// # Summary
/// Advanced quantum synthetic data generator with configurable parameters
@EntryPoint()
operation AdvancedQuantumDataGenerator() : QuantumDataSample[] {
    Message("=== Advanced Quantum Synthetic Data Generator ===");
    
    let config = DataConfig(20, true, 0.1);
    Message($"Configuration: Samples={config.SampleSize}, Entanglement={config.UseEntanglement}, Noise={config.NoiseLevel}");
    
    mutable samples = [];
    
    for i in 0..config.SampleSize-1 {
        let sample = GenerateAdvancedSample(i, config);
        set samples += [sample];
        
        if i % 5 == 0 {
            Message($"Generated {i + 1} samples...");
        }
    }
    
    Message($"✓ Successfully generated {Length(samples)} quantum synthetic data samples!");
    AnalyzeDataDistribution(samples);
    
    return samples;
}

/// # Summary
/// Generates a single sample using advanced quantum techniques
operation GenerateAdvancedSample(id : Int, config : DataConfig) : QuantumDataSample {
    
    // Generate correlated features using quantum entanglement
    let (age, income) = if config.UseEntanglement {
        GenerateEntangledAgeIncome()
    } else {
        (GenerateQuantumAge(), GenerateQuantumIncome())
    };
    
    // Generate category using quantum walk
    let category = GenerateQuantumWalkCategory();
    
    // Generate binary flag using variational quantum circuit
    let binaryFlag = GenerateVariationalBinaryFlag(IntAsDouble(age) / 80.0);
    
    // Create quantum fingerprint for authenticity
    let fingerprint = GenerateQuantumFingerprint(id);
    
    // Apply quantum noise if configured
    let noisyAge = if config.NoiseLevel > 0.0 {
        AddQuantumNoise(age, config.NoiseLevel)
    } else {
        age
    };
    
    return QuantumDataSample(id, noisyAge, income, category, binaryFlag, fingerprint);
}

/// # Summary
/// Generates entangled age and income using Bell states
operation GenerateEntangledAgeIncome() : (Int, Int) {
    use qubits = Qubit[8];
    
    // Create Bell pairs for correlation
    H(qubits[0]);
    CNOT(qubits[0], qubits[4]); // Entangle age and income generators
    
    // Age generation circuit
    for i in 1..3 {
        H(qubits[i]);
        // Add correlation bias
        Controlled Ry([qubits[0]], (PI() / 6.0, qubits[i]));
    }
    
    // Income generation circuit (entangled with age)
    for i in 5..7 {
        H(qubits[i]);
        // Stronger correlation for income
        Controlled Ry([qubits[4]], (PI() / 4.0, qubits[i]));
    }
    
    // Add cross-correlations
    CNOT(qubits[1], qubits[5]);
    CNOT(qubits[2], qubits[6]);
    
    let results = MeasureEachZ(qubits);
    
    let ageRaw = ResultArrayAsInt([results[0], results[1], results[2], results[3]]);
    let incomeRaw = ResultArrayAsInt([results[4], results[5], results[6], results[7]]);
    
    // Map to realistic ranges with correlation
    let age = 18 + (ageRaw % 63);
    let baseIncome = 20000 + (incomeRaw * 2000);
    let ageMultiplier = 1.0 + (IntAsDouble(age - 18) / 62.0) * 2.0; // Age correlation
    let income = Truncate(IntAsDouble(baseIncome) * ageMultiplier);
    
    ResetAll(qubits);
    return (age, income);
}

/// # Summary
/// Generates category using quantum walk algorithm
operation GenerateQuantumWalkCategory() : String {
    use walker = Qubit[3]; // Position qubits
    use coin = Qubit();    // Coin qubit for quantum walk
    
    // Initialize coin in superposition
    H(coin);
    
    // Perform quantum walk steps
    for step in 1..4 {
        // Coin flip
        H(coin);
        
        // Conditional walk step based on coin
        Controlled X([coin], walker[0]);
        
        // Add quantum interference
        for i in 0..2 {
            Controlled H([walker[i]], coin);
        }
        
        // Phase kicks for bias
        Controlled Z([coin], walker[1]);
    }
    
    let coinResult = M(coin);
    let walkerResults = MeasureEachZ(walker);
    let position = ResultArrayAsInt(walkerResults);
    
    Reset(coin);
    ResetAll(walker);
    
    // Map walk position to categories with quantum bias
    let totalResult = position + (coinResult == One ? 4 | 0);
    
    if totalResult < 2 {
        return "A";
    } elif totalResult < 4 {
        return "B"; 
    } elif totalResult < 6 {
        return "C";
    } else {
        return "D";
    }
}

/// # Summary
/// Uses variational quantum circuit for binary flag generation
operation GenerateVariationalBinaryFlag(parameter : Double) : Bool {
    use qubits = Qubit[2];
    
    // Variational ansatz with parameterized gates
    let theta1 = parameter * PI();
    let theta2 = (1.0 - parameter) * PI() / 2.0;
    
    // Layer 1: Rotation gates
    Ry(theta1, qubits[0]);
    Ry(theta2, qubits[1]);
    
    // Layer 2: Entangling gate
    CNOT(qubits[0], qubits[1]);
    
    // Layer 3: More rotations
    Ry(theta1 / 2.0, qubits[0]);
    Rx(theta2 / 2.0, qubits[1]);
    
    // Final entangling
    CNOT(qubits[1], qubits[0]);
    
    let result = M(qubits[0]);
    ResetAll(qubits);
    
    return result == One;
}

/// # Summary
/// Generates a quantum fingerprint for data authenticity
operation GenerateQuantumFingerprint(id : Int) : Int[] {
    use qubits = Qubit[4];
    
    // Initialize based on ID (ensure it fits in 4 bits)
    let clampedId = id % 16; // Clamp to 0-15 for 4 bits
    let idBits = IntAsBoolArray(clampedId, 4);
    
    for i in 0..3 {
        if idBits[i] {
            X(qubits[i]);
        }
    }
    
    // Apply quantum evolution to create fingerprint
    for round in 1..3 {
        // Hadamard layer
        ApplyToEach(H, qubits);
        
        // Entangling layer
        for i in 0..2 {
            CNOT(qubits[i], qubits[(i + 1) % 4]);
        }
        
        // Phase layer
        for i in 0..3 {
            T(qubits[i]);
        }
    }
    
    let results = MeasureEachZ(qubits);
    ResetAll(qubits);
    
    mutable fingerprint = [];
    for result in results {
        set fingerprint += [result == One ? 1 | 0];
    }
    
    return fingerprint;
}

/// # Summary
/// Generates standalone quantum age with normal distribution bias
operation GenerateQuantumAge() : Int {
    use qubits = Qubit[6];
    
    // Create normal distribution bias using quantum interference
    for i in 0..5 {
        H(qubits[i]);
    }
    
    // Add bias toward center (normal distribution approximation)
    for i in 1..4 {
        Controlled Ry([qubits[0]], (PI() / IntAsDouble(i + 2), qubits[i]));
    }
    
    // Cross-correlations for smoother distribution
    CNOT(qubits[1], qubits[3]);
    CNOT(qubits[2], qubits[4]);
    
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // Apply normal distribution transformation
    let normalizedValue = IntAsDouble(rawValue) / 63.0;
    let gaussianValue = BoxMullerTransform(normalizedValue);
    let age = Truncate(40.0 + gaussianValue * 15.0); // Mean=40, Std=15
    
    ResetAll(qubits);
    return MaxI(18, MinI(80, age)); // Clamp to valid range
}

/// # Summary
/// Generates standalone quantum income
operation GenerateQuantumIncome() : Int {
    use qubits = Qubit[8];
    
    // Exponential distribution bias
    ApplyToEach(H, qubits);
    
    // Create exponential bias
    for i in 1..7 {
        let weight = 1.0 / IntAsDouble(i + 1);
        Controlled Ry([qubits[0]], (weight * PI(), qubits[i]));
    }
    
    let results = MeasureEachZ(qubits);
    let rawValue = ResultArrayAsInt(results);
    
    // Exponential transformation
    let normalized = IntAsDouble(rawValue) / 255.0;
    let exponential = -Log(1.0 - normalized + 0.001) * 30000.0;
    let income = Truncate(exponential + 20000.0);
    
    ResetAll(qubits);
    return MinI(150000, MaxI(20000, income)); // Clamp to valid range
}

/// # Summary
/// Box-Muller transformation for normal distribution
function BoxMullerTransform(uniform : Double) : Double {
    // Simplified version using just the uniform input
    // In practice, this would use two uniform random variables
    let scaled = uniform * 2.0 * PI();
    return Cos(scaled) * Sqrt(-2.0 * Log(uniform + 0.001));
}

/// # Summary
/// Analyzes the generated data distribution
function AnalyzeDataDistribution(samples : QuantumDataSample[]) : Unit {
    Message("\n=== Data Distribution Analysis ===");
    
    mutable ageSum = 0;
    mutable incomeSum = 0;
    mutable categoryACnt = 0;
    mutable categoryBCnt = 0;
    mutable categoryCCnt = 0;
    mutable categoryDCnt = 0;
    mutable trueFlagCnt = 0;
    
    for sample in samples {
        set ageSum += sample.Age;
        set incomeSum += sample.Income;
        set trueFlagCnt += sample.BinaryFlag ? 1 | 0;
        
        if sample.Category == "A" { set categoryACnt += 1; }
        elif sample.Category == "B" { set categoryBCnt += 1; }
        elif sample.Category == "C" { set categoryCCnt += 1; }
        else { set categoryDCnt += 1; }
    }
    
    let avgAge = IntAsDouble(ageSum) / IntAsDouble(Length(samples));
    let avgIncome = IntAsDouble(incomeSum) / IntAsDouble(Length(samples));
    let trueFlagPct = IntAsDouble(trueFlagCnt) / IntAsDouble(Length(samples)) * 100.0;
    
    Message($"Average Age: {avgAge}");
    Message($"Average Income: ${avgIncome}");
    Message($"Category Distribution: A={categoryACnt}, B={categoryBCnt}, C={categoryCCnt}, D={categoryDCnt}");
    Message($"Binary Flag True Percentage: {trueFlagPct}%");
    Message("=== Analysis Complete ===\n");
}

/// # Summary
/// Adds quantum noise to a value for data augmentation
operation AddQuantumNoise(originalValue : Int, noiseLevel : Double) : Int {
    use qubit = Qubit();
    
    // Apply rotation based on noise level
    Ry(noiseLevel * PI(), qubit);
    
    let result = MResetZ(qubit);
    let noise = if result == One { 
        Truncate(noiseLevel * 10.0) 
    } else { 
        -Truncate(noiseLevel * 10.0) 
    };
    
    return originalValue + noise;
}