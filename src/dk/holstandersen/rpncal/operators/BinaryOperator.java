package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public interface BinaryOperator {
	public Double calculate(Double arg1, Double arg2) throws RPNOperationException;
}
