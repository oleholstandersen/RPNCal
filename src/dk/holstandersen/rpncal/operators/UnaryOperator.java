package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public interface UnaryOperator {
	public Double invoke(Double arg) throws RPNOperationException;
}
