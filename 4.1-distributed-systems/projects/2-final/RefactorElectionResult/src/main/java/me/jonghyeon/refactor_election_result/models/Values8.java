package me.jonghyeon.refactor_election_result.models;

import java.io.Serializable;

public class Values8 implements Serializable {
  public float economic;
  public float diplomatic;
  public float civil;
  public float society;

  public Values8(float economic, float diplomatic, float civil, float society) {
    this.economic = economic;
    this.diplomatic = diplomatic;
    this.civil = civil;
    this.society = society;
  }

  public Values8() {
    this(0, 0, 0, 0);
  }

  @Override
  public String toString() {
    return String.format("Economic: %.2f, Diplomatic: %.2f, Civil: %.2f, Society: %.2f",
        economic, diplomatic, civil, society);
  }

  public Values8 add(Values8 other) {
    return new Values8(
        this.economic + other.economic,
        this.diplomatic + other.diplomatic,
        this.civil + other.civil,
        this.society + other.society
    );
  }

  public Values8 sub(Values8 other) {
    return new Values8(
        this.economic - other.economic,
        this.diplomatic - other.diplomatic,
        this.civil - other.civil,
        this.society - other.society
    );
  }

  public Values8 mul(float factor) {
    return new Values8(
        this.economic * factor,
        this.diplomatic * factor,
        this.civil * factor,
        this.society * factor
    );
  }

  public Values8 divide(float divisor) {
    if (divisor == 0) {
      throw new IllegalArgumentException("Divisor cannot be zero");
    }
    return new Values8(
        this.economic / divisor,
        this.diplomatic / divisor,
        this.civil / divisor,
        this.society / divisor
    );
  }
}
