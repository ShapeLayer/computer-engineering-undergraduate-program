package io.github.shapelayer.commons;

import io.github.shapelayer.models.Party;
import io.github.shapelayer.models.Struct8Values;

import java.util.HashMap;
import java.util.Map;

public class PartySupport {
  public static Map<Party, String> partyEnumToString = new HashMap<Party, String>() {{
    put(Party.DEMOCRATIC_PARTY_OF_KOREA, Presets.NAME_DEMOCRATIC_PARTY_OF_KOREA);
    put(Party.UNITED_FUTURE_PARTY, Presets.NAME_UNITED_FUTURE_PARTY);
    put(Party.MINSAENGDANG, Presets.NAME_MINSAENGDANG);
    put(Party.JUSTICE_PARTY, Presets.NAME_JUSTICE_PARTY);
    put(Party.OUR_REPUBLICAN_PARTY, Presets.NAME_OUR_REPUBLICAN_PARTY);
    put(Party.THE_PEOPLES_PARTY_OF_SOUTH_KOREA, Presets.NAME_THE_PEOPLES_PARTY_OF_SOUTH_KOREA);
    put(Party.KOREAN_ECONOMIC_PARTY, Presets.NAME_KOREAN_ECONOMIC_PARTY);
    put(Party.THE_PEOPLES_PARTY, Presets.NAME_THE_PEOPLES_PARTY);
    put(Party.PRO_PARK_NEW_PARTY, Presets.NAME_PRO_PARK_NEW_PARTY);
    put(Party.OPEN_DEMOCRATIC_PARTY, Presets.NAME_OPEN_DEMOCRATIC_PARTY);
  }};
  public static String toString(Party party) {
    return partyEnumToString.get(party);
  }

  public static Map<Party, Struct8Values> partyEnumTo8Values = new HashMap<Party, Struct8Values>() {{
    put(Party.DEMOCRATIC_PARTY_OF_KOREA, Presets.VALUES_DEMOCRATIC_PARTY_OF_KOREA);
    put(Party.UNITED_FUTURE_PARTY, Presets.VALUES_UNITED_FUTURE_PARTY);
    put(Party.MINSAENGDANG, Presets.VALUES_MINSAENGDANG);
    put(Party.JUSTICE_PARTY, Presets.VALUES_JUSTICE_PARTY);
    put(Party.OUR_REPUBLICAN_PARTY, Presets.VALUES_OUR_REPUBLICAN_PARTY);
    put(Party.THE_PEOPLES_PARTY_OF_SOUTH_KOREA, Presets.VALUES_THE_PEOPLES_PARTY_OF_SOUTH_KOREA);
    put(Party.KOREAN_ECONOMIC_PARTY, Presets.VALUES_KOREAN_ECONOMIC_PARTY);
    put(Party.THE_PEOPLES_PARTY, Presets.VALUES_THE_PEOPLES_PARTY);
    put(Party.PRO_PARK_NEW_PARTY, Presets.VALUES_PRO_PARK_NEW_PARTY);
    put(Party.OPEN_DEMOCRATIC_PARTY, Presets.VALUES_OPEN_DEMOCRATIC_PARTY);
  }};
  public static Struct8Values to8Values(Party party) {
    return partyEnumTo8Values.get(party);
  }
}
