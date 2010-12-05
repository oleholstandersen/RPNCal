package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public interface NullaryOperator extends Operator {
	public Double calculate() throws RPNOperationException;
}
