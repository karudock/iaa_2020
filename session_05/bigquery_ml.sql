/* ########################################################
#
# BigQuery ML - SQL code to train Logistic Regression Model
#
########################################################### */

CREATE OR REPLACE MODEL `zdataset.banking_attrition_model`
OPTIONS(model_type='logistic_reg') AS
SELECT
  attrition as label,
  age,
  `default` as default_flag,
  gender,
  membership,
  charges,
  customer_contacts
FROM
  `zproject201807.zdataset.banking_attrition`


/* ########################################################
#
# BigQuery ML - SQL code to make predicts with the model
#
########################################################### */

SELECT
  *
FROM
  ML.PREDICT(MODEL `zproject201807.zdataset.banking_attrition_model`, (
SELECT
  age,
  `default` as default_flag,
  gender,
  membership,
  charges,
  customer_contacts
FROM
  `zproject201807.zdataset.banking_attrition`
))

