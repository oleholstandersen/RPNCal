package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public interface UnaryOperator extends Operator {
	public Double calculate(Double arg) throws RPNOperationException;
}
