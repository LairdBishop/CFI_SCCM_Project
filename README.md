To be packaged in support of Dynamic Driver Injection in the DellEMC factory.  
# CFI SCCM Project

This repo contains documents and files related to an SCCM boot in factory project with DellEMC.

## Essential documents (Mandatory)

### [SCCM_Boot_in_the_Factory_USERGUIDE_092018.pdf](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/SCCM_Boot_in_the_Factory_USERGUIDE_092018.pdf)
---
You may hear this document referred to in short as the "User Guide" or the "White Paper" as you interact with your IMS engineer or project manager.  

**_Please invest the time to fully read and understand this document, which serves as the definitive guide for this type of project._**  The majority of media failures, project delays, factory exceptions and customer escapes we encounter can be traced to deviation from the user guide.

If you have any questions as you work toward implementation please reach out to your assigned IMS engineer who will be happy to assist. 

### [sccm_mdt_ims_techspec_5_3.docm  - the "IMS TechSpec" ](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/sccm_mdt_ims_techspec_5_3.docm)
---
**_DO FIRST! This document must be completed fully and accurately at the outset of any project and returned to your IMS engineer and project manager._**

This document tells us everything we need to know to get your project and testing set up correctly.  Please take a few minutes to complete one document for each project (SI#).  If you have any questions please reach out to your assigned IMS engineer for assistance. 

## Supporting files

### [ImportCustomDrivers.vbs](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/ImportCustomDrivers.vbs)
---
Used to facilitate Dynamic Driver Injection in the DellEMC factory.
See page 9 of the  ["User Guide"](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/SCCM_Boot_in_the_Factory_USERGUIDE_092018.pdf)

### [Check_AC_Power.vbs](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/Check_AC_Power.vbs)
---
Used to alert in the event a laptop is running on battery.  Necessary when implementing BitLocker partition creation in an SCCM factory task sequence.
See page 15 of the  ["User Guide"](https://github.com/LairdBishop/CFI_SCCM_Project/blob/master/SCCM_Boot_in_the_Factory_USERGUIDE_092018.pdf)
