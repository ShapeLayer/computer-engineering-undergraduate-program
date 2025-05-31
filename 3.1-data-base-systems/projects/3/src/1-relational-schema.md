# 데이터베이스시스템 Term Project #3

## 약물 <sup><code>drugs</code></sup>
| <u>약물 ID <sup><code>id</code></sup></u> | 약물 이름 <sup><code>name</code></sup> | 설명 <sup><code>description</code></sup> | CAS 번호 <sup><code>cas_number</code></sup> | 상태 <sup><code>state</code></sup> | UNII <sup><code>unii</code></sup> |
| :-: | :-: | --- | :-: | :-: | :-: |
| DB00039 | Palifermin | "Palifermin is a recombinant human keratinocyte growth factor (KGF). It is 140 residues long, and is produced using E. coli. \n \nPalifermin was granted FDA approval on 15 December 2004.[L17933]" | 162394-19-6 | liquid | QMS40680K6 |
| DB00040 | Glucagon | "Glucagon is a 29 amino acid hormone used as a diagnostic aid in radiologic exams to temporarily inhibit the movement of the gastrointestinal tract and to treat severe hypoglycemia.[L7634,L7637,L7640,L7643,L8519] Glucagon raises blood sugar through activation of hepatic glucagon receptors, stimulating glycogenolysis and the release of glucose.[L7640,L7643] \n \nGlucagon was granted FDA approval on 14 November 1960.[L7631]" | 16941-32-5 | liquid | 76LA80IG2G |
| DB00041 | Aldesleukin | "Aldesleukin, a lymphokine, is produced by recombinant DNA technology using a genetically engineered E. coli strain containing an analog of the human interleukin-2 gene. Genetic engineering techniques were used to modify the human IL-2 gene, and the resulting expression clone encodes a modified human interleukin-2. This recombinant form differs from native interleukin-2 in the following ways: a) Aldesleukin is not glycosylated because it is derived from E. coli; b) the molecule has no N-terminal alanine; the codon for this amino acid was deleted during the genetic engineering procedure; c) the molecule has serine substituted for cysteine at amino acid position 125." | 110942-02-4 | liquid | M89N0Q7EQR |
| DB00042 | Botulinum toxin type B | Neurotoxin produced by fermentation of clostridium botulinum type B. The protein exists in noncovalent association with hemagglutinin and nonhemagglutinin proteins as a neurotoxin complex. The neurotoxin complex is recovered from the fermentation process and purified through a series of precipitation and chromatography steps. | 93384-44-2 | liquid | 0Y70779M1F |
| DB00043 | Omalizumab | "Omalizumab, manufactured by _Genentech_, was first FDA approved in 2003 to treat adults and children 12 years of age and older with moderate to severe persistent allergic asthma which is not controlled by inhaled steroids [L4670]. Since its U.S. approval, more than 200,000 patients older than 12 with allergic asthma have been treated [L4670].  In September 2018, a new prefilled syringe formulation of this drug was approved by the FDA [L4671]." | 242138-07-4 | solid | 2P471X1Z11 |


## 카테고리 <sup><code>categories</code></sup>
| <u>카테고리 ID <sup><code>id</code></sup> | 카테고리 이름 <sup><code>name</code></sup></u> |
| :-: | :-: |
| D058917 | Adenosine A2 Receptor Antagonists |
| D058919 | Purinergic P2 Receptor Antagonists |
| D058921 | Purinergic P2Y Receptor Antagonists |
| D058924 | Thienopyridines |
| D058950 | Melanoma-Specific Antigens |
| D058955 | Metalloids |

## 약물-카테고리 관계 <sup><code>drug_categories</code></sup>
| 약물 ID <sup><code>drug_id</code></sup> | 카테고리 ID <sup><code>category_id</code></sup> |
| :-: | :-: |
| DB16267 | D065693 |
| DB00030 | D065694 |
| DB00046 | D065694 |
| DB00047 | D065694 |

## 외부 DB 식별자 <sup><code>external_db_identifiers</code></sup>
| <u>ID <sup><code>id</code></sup></u> | 외부 ID <sup><code>external_id</code></sup> | 유래 약물 <sup><code>derived_from</code></sup> | 리소스 <sup><code>resource</code></sup> |
| :-: | :-: | :-: | :-: |
| 11f03d37-7e2e-82d8-8f74-e2c01f351b76 | PA164760860 | DB00059 | PharmGKB |
| 11f03d37-7e2e-8512-8f74-e2c01f351b76 | Pegaspargase | DB00059 |  Wikipedia|
| 11f03d37-7e2e-8742-8f74-e2c01f351b76 | CHEMBL2108546 | DB00059 | ChEMBL |
| 11f03d37-7e2e-8940-8f74-e2c01f351b76 | 34132 | DB00059 | RxCUI |

## 상품 <sup><code>products</code></sup>
| <u>ID <sup><code>id</code></sup></u> | 유래 약물 <sup><code>derived_from</code></sup> | 상품명 <sup><code>name</code></sup> | 제조사 <sup><code>labeller</code></sup> | 강도 <sup><code>strength</code></sup> | 투여 경로 <sup><code>route</code></sup> | 승인 여부 <sup><code>approved</code></sup> | NDC 제품 코드 <sup><code>ndc_product_code</code></sup> | EMA MA 번호 <sup><code>ema_ma_number</code></sup> |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 11f03d37-815f-8ef2-8f74-e2c01f351b76 | DB00008 | Pegasys | "Genentech, Inc." | 180 ug/0.5mL | Subcutaneous | 1 | 0004-0365 |  |
| 11f03d37-815f-9118-8f74-e2c01f351b76 | DB00008 | Pegasys | Hoffmann La Roche | 180 mcg / 0.5 mL | Subcutaneous | 1 | | |
| 11f03d37-815f-9366-8f74-e2c01f351b76 | DB00008 | Pegasys | Hoffmann La Roche | 180 mcg / mL | Subcutaneous | 1 |  |  |
| 11f03d37-815f-956e-8f74-e2c01f351b76 | DB00008 | Pegasys | Zr Pharma& Gmbh | 180 ug/1mL | Subcutaneous | 1 | 82154-0449 |  |
| 11f03d37-815f-979e-8f74-e2c01f351b76 | DB00008 | Pegasys | Zr Pharma& Gmbh | 180 ug/0.5mL | Subcutaneous | 1 | 82154-0451 | |
| 11f03d37-815f-99a6-8f74-e2c01f351b76 | DB00008 | Pegasys | Zr Pharma& Gmb H | 135 μg | Subcutaneous | 1 | | EU/1/02/221/001 |
| 11f03d37-815f-a284-8f74-e2c01f351b76 | DB00008 | Pegasys | Zr Pharma& Gmb H | 135 μg | Subcutaneous | 1 | | EU/1/02/221/002 |


## 실험 속성 <sup><code>experimental_properties</code></sup>
| <u>ID <sup><code>id</code></sup></u> | 유래 약물 <sup><code>derived_from</code></sup> | 종류 <sup><code>kind</code></sup> | 값 <sup><code>value</code></sup> | 단위 <sup><code>unit</code></sup> |
| :-: | :-: | :-: | :-: | :-: |
| 11f03d37-8e88-0488-8f74-e2c01f351b76 | DB04825 | Melting Point | 36.5 °C | PhysProp |
| 11f03d37-8e88-06b8-8f74-e2c01f351b76 | DB04826 | Melting Point | 96 °C | PhysProp |
| 11f03d37-8e88-08fc-8f74-e2c01f351b76 | DB04826 | Boiling Point | 159 °C at 2.00E-02 mm Hg | PhysProp |
| 11f03d37-8e88-0b9a-8f74-e2c01f351b76 | DB04827 | Water Solubility | 4.8E+005 mg/L (at 15 °C) | "SEIDELL,A (1941)" |
| 11f03d37-8e88-0eb0-8f74-e2c01f351b76 | DB04827 | Melting Point | 49 °C | PhysProp |
| 11f03d37-8e88-1162-8f74-e2c01f351b76 | DB04827 | Boiling Point | 185 °C | PhysProp |

## 작용 대상 <sup><code>targets</code></sup>
| <u>대상 ID <sup><code>id</code></sup></u> | 대상 이름 <sup><code>name</code></sup> | 생물체 <sup><code>organism</code></sup> |
| :-: | :-: | :-: |
| BE0000140 | Solute carrier family 12 member 6 | Humans |
| BE0000141 | Sodium channel protein type 1 subunit alpha | Humans |
| BE0000142 | Penicillin-binding protein 2B | Streptococcus pneumoniae  |serotype 4 (strain ATCC BAA-334 / TIGR4)
| BE0000143 | Tubulin beta chain | Humans |
| BE0000144 | Retinoic acid receptor gamma | Humans |
| BE0000145 | Dopamine D5 receptor | Humans |


## 약물-작용 대상 관계 <sup><code>drug_targets</code></sup>
| 약물 ID <sup><code>drug_id</code></sup> | 대상 ID <sup><code>target_id</code></sup> |
| :-: | :-: |
| DB12010 | BE0009442 |
| DB12010 | BE0009443 |
| DB12010 | BE0009444 |
| DB12010 | BE0009445 |
| DB12010 | BE0009446 |
| DB12010 | BE0009447 |
| DB12010 | BE0009448 |
| DB12010 | BE0009449 |

## 참조 문헌 <sup><code>references</code></sup>
| <u>참조 ID <sup><code>ref_id</code></sup></u> | PubMed ID <sup><code>pubmed_id</code></sup> | 인용 <sup><code>citation</code></sup> |
| :-: | :-: | --- |
| A10031 | 2550053 | "Rudy B, Dubois H, Mink R, Trommer WE, McIntyre JO, Fleischer S: Coenzyme binding by 3-hydroxybutyrate dehydrogenase, a lipid-requiring enzyme: lecithin acts as an allosteric modulator to enhance the affinity for coenzyme. Biochemistry. 1989 Jun 27;28(13):5354-66." |
| A10032 | 38961 | "Smith CM, Plaut GW: Activities of NAD-specific and NADP-specific isocitrate dehydrogenases in rat-liver mitochondria. Studies with D-threo-alpha-methylisocitrate. Eur J Biochem. 1979 Jun;97(1):283-95." |
| A10033 | 16983536 | "Drew DP, Lunde C, Lahnstein J, Fincher GB: Heterologous expression of cDNAs encoding monodehydroascorbate reductases from the moss, Physcomitrella patens and characterization of the expressed enzymes. Planta. 2007 Mar;225(4):945-54." |
| A10034 | 237755 | "Inano H, Tamaoki B: Relationship between steroids and pyridine nucleotides in the oxido-reduction catalyzed by the 17 beta-hydroxysteroid dehydrogenase purified from the porcine testicular microsomal fraction. Eur J Biochem. 1975 May 6;53(2):319-26." |
| A10035 | 15755483 | "Huber R, Riepe MW: Improved posthypoxic recovery in vitro on treatment with drugs used for secondary stroke prevention. Neuropharmacology. 2005 Mar;48(4):558-65." |
| A10036 | 15152097 | "Hedl M, Rodwell VW: Inhibition of the class II HMG-CoA reductase of Pseudomonas mevalonii. Protein Sci. 2004 Jun;13(6):1693-7." |
| A10037 | 14511985 | "Li S, Wagner CA, Friesen JA, Borst DW: 3-hydroxy-3-methylglutaryl-coenzyme A reductase in the lobster mandibular organ: regulation by the eyestalk. Gen Comp Endocrinol. 2003 Nov;134(2):147-55." |
| A10038 | 17197218 | "McKinlay JB, Shachar-Hill Y, Zeikus JG, Vieille C: Determining Actinobacillus succinogenes metabolic pathways and fluxes by NMR and GC-MS analyses of 13C-labeled metabolic product isotopomers. Metab Eng. 2007 Mar;9(2):177-92. Epub 2006 Nov 17." |
| A10039 | 2692566 | Grant GA: A new family of 2-hydroxyacid dehydrogenases. Biochem Biophys Res Commun. 1989 Dec 29;165(3):1371-4. |


## 약물-참조 문헌 관계 <sup><code>drug_references</code></sup>
| 약물 ID <sup><code>drug_id</code></sup> | 참조 ID <sup><code>ref_id</code></sup> |
| :-: | :-: |
| DB00157 | A10001 |
| DB00157 | A10002 |
| DB00157 | A10003 |
| DB00157 | A10004 |
| DB00162 | A10004 |
| DB00157 | A10005 |
| DB00126 | A100057 |
| DB00157 | A10006 |
| DB00157 | A10007 |
| DB00157 | A10008 |
| DB00157 | A10009 |
