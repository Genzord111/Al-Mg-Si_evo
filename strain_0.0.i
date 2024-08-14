# ~/moose_projects/newt/examples/Sachin/Al-Cu-Ni$ mpiexec -n 22 ~/moose_projects/newt/newt-opt -i Al_Cu_Ni_el.i
# Authored by Sachin Poudel July 12 2023
# The eta1 region (Al rich) grows
# The eta2 region shrinks
# so the eta1 and eta3 variables are represented by same value of bulk free energy F1
# Since bulk F1 is a function of c1a, c1b and c2b, so the phase compositions of eta3 are also c1a,c1b and c1c
# Thus, c3a=c1a, c3b=c1b and c3c=c1c 
# Hence the variables c1a, c1b and c1c represent the phase compositions of both eta1 and eta3
# This test is for the 2-phase KKS model
###########################################################################################################################
# The multicomponent is represented by the suffixes a and b for ternary system A-B-C
# For multiphase system with eta1, eta2, and eta3, the suffixes 1,2 and 3 come after the variables and materials properties  
############################################################################################################################
# [GlobalParams]
#   displacements = 'disp_x disp_y'
# []

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 34 #20 #50 #110 #50 #20
  ny = 34 #20 #50 #110 #50 #20
  nz = 0
  xmin = 0
  xmax = 600 # nm
  ymin = 0
  ymax = 600  # nm
  zmin = 0
  zmax = 0  # nm
  elem_type = QUAD4
[]
#########################################################################################
[BCs]
  [./Periodic]
    [./all]
      auto_direction = 'x y'
      #auto_direction = 'x'
    [../]
  [../]
  
    [./right_x]
      type = DirichletBC
      variable = disp_x
      boundary = right
      value = 0
    [../]

      [./left_x]
        type = DirichletBC
        variable = disp_x
        boundary = left
        value = 0
      [../]     

      [./top_x]
        type = DirichletBC
        variable = disp_x
        boundary = top
        value = 0
      [../]
  
        [./bottom_x]
          type = DirichletBC
          variable = disp_x
          boundary = bottom
          value = 0
        [../]   
###############################
      [./right_y]
        type = DirichletBC
        variable = disp_y
        boundary = right
        value = 0
      [../]
  
        [./left_y]
          type = DirichletBC
          variable = disp_y
          boundary = left
          value = 0
        [../]     
    
      [./top_y]
        type = DirichletBC
        variable = disp_y
        boundary = top
        value = 0
      [../]
  
        [./bottom_y]
          type = DirichletBC
          variable = disp_y
          boundary = bottom
          value = 0
        [../]      

 # [./neumann1]
 #       type = NeumannBC
  #      boundary = 'bottom'
  #      variable = 'eta3'
  #      value = 0
   # [../]
   # [./neumann2]
   #    type = NeumannBC
   #     boundary = 'top'
   #     variable = 'eta1'
   #     value = 0
   #[../]
[]
#########################################################################################
[AuxVariables]
  [./bnds]
  [../]
  [./Energy]
    order = CONSTANT
    family = MONOMIAL
  [../]

# For visualizing the boundary of phases of grain for composition simulation
   [./gr_ca]
      order = CONSTANT
     family = MONOMIAL
    [../]

     [./gr_cb]
      order = CONSTANT
     family = MONOMIAL
    [../]

    #  [./gr_cc]
    #   order = CONSTANT
    #  family = MONOMIAL
    # [../]

##################
# # Stress due to elasticity considerations
[./von_mises]
  #Dependent variable used to visualize the Von Mises stress
  order = CONSTANT
  family = MONOMIAL
[../]
[./sigma11]
  order = CONSTANT
  family = MONOMIAL
[../]
[./sigma22]
  order = CONSTANT
  family = MONOMIAL
[../]
[./sigma12]
  order = CONSTANT
  family = MONOMIAL
[../]
[./e11]
  order = CONSTANT
  family = MONOMIAL
[../]
[./e12]
  order = CONSTANT
  family = MONOMIAL
[../]
[./e22]
  order = CONSTANT
  family = MONOMIAL
[../]
[./e33]
  order = CONSTANT
  family = MONOMIAL
[../]


[]
#########################################################################################
[Variables]
# For A-B-C alloy, cA+cB+cC = 1
# So, DOF = 2 i.e. cA and cB, are sufficient to describe the composition of the ternary system A-B-C
############################################
  # potential variable used in SplitCHCRes and kkssplitchcres (global)
  [./wa] #A 
    order = FIRST
    family = LAGRANGE
    scaling=1.0E6
  [../]
  
  [./wb] # B
    order = FIRST
    family = LAGRANGE
    scaling=1.0E6
  [../]

############################################
  # concentration (global) of A
  [./ca]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
  [../]
  
   # concentration (global) of B
  [./cb]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
  [../]

################################################################ 
# Phase concentrations corresponding to global composition cA
############################################################### 
  # phase concentration 1
  [./c1a]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
    #initial_condition = 0.2
  [../]
######################
  # phase concentration 2
  [./c2a]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
    #initial_condition = 0.7
  [../]
######################
 # phase concentration 3
 [./c3a]
   order = FIRST
   family = LAGRANGE
  #  scaling=1.0E-09
   #initial_condition = 0.8
 [../]
################################################################ 
# Phase concentrations corresponding to global composition cB
############################################################### 
  # phase concentration 1
  [./c1b]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
    #initial_condition = 0.2
  [../]
######################
  # phase concentration 2
  [./c2b]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-09
    #initial_condition = 0.5
  [../]
######################
 # phase concentration 3
[./c3b]
  order = FIRST
   family = LAGRANGE
  #  scaling=1.0E-09
   #initial_condition = 0.8
 [../]
############################################
  # order parameter 1
  [./eta1]
    order = FIRST
    family = LAGRANGE
    
    # scaling=1.0E-06
  [../]
######################
  # order parameter 2
  [./eta2]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-06
  [../]
######################
  # order parameter 3
  [./eta3]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-06
    #initial_condition = 0.0
  [../]
  ######################
  # order parameter 4
 [./eta4]
   order = FIRST
   family = LAGRANGE
  # scaling=1.0E-06
 [../]
######################
  # order parameter 5
 [./eta5]
   order = FIRST
   family = LAGRANGE
  # scaling=1.0E-06
 [../]
######################
  # order parameter 6
  [./eta6]
    order = FIRST
    family = LAGRANGE
    # scaling=1.0E-06s
  [../]
 ######################
#### For Elasticity
# Displacement variables for NS equation 
 [./disp_x]
  scaling=1.0E-05 
  [../]
  [./disp_y]
    scaling=1.0E-05 
  [../]

[]
#########################################################################################

[ICs]

#  ################################################
#  #  
#  #          
#  #          o
#  #        eta3                  o
#  #      (260, 400)            eta4
#  #                          (400, 350)
#  #                    o
#  #                  eta2               
#  #              (300, 300)        o
#  #        o                       eta5
#  #        eta1                  (400, 250)
#  #      (260, 200)
#  # 
#  #  
#  #  
#  #  
#  #  eta1, eta2,  --> r=40, Al2Cu      eta3, eta4, eta5 --> r=60, Al3Ni
#  ################################################
############################################
[./eta1]  # extends from y = 0 to y = 25 , x no change
    variable = eta1
    type = FunctionIC
    # function = 'r:=sqrt((x-300)^2+(y-300)^2);if(r<=50,1,0)'
    # function = 'if(x>=50&y>=100&x<=200&y<=400,1,0)'
function = 'r:=sqrt(0.6*(x-200)^2+(y-150)^2);if(r<=80,1,0)'
[../]
############################################
[./eta2]  # extends from y = 0 to y = 25 , x no change
  variable = eta2
  type = FunctionIC
  # function = 'r:=sqrt((x-400)^2+(y-200)^2);if(r<=50,1,0)'
  # function = 'if(x>=400&y>=180&x<=550&y<=320,1,0)'
  function = 'r:=sqrt((x-280)^2+(y-380)^2);if(r<=90,1,0)'
[../]
############################################
[./eta3]  # extends from y = 0 to y = 25 , x no change
variable = eta3
type = FunctionIC
# function = 'r:=sqrt((x-260)^2+(y-200)^2);if(r<=40,1,0)'   
# function = 'if(x>=300&y>=120&x<=350&y<=230,1,0)'
function = 'r:=sqrt((x-210)^2+(y-490)^2);if(r<=40,1,0)'
[../]
############################################
[./eta4]  # extends from y = 0 to y = 25 , x no change
  variable = eta4
  type = FunctionIC
  # function = 'r:=sqrt((x-260)^2+(y-400)^2);if(r<=40,1,0)' # Using 60 square
  # function = 'if(x>=180&y>=430&x<=240&y<=490,1,0)'
  function = 'r:=sqrt((x-420)^2+(y-400)^2);if(r<=50,1,0)' # Using 60 square
[../]
############################################
[./eta5]  # extends from y = 0 to y = 25 , x no change
    variable = eta5
    type = FunctionIC
    # function = 'r:=sqrt((x-400)^2+(y-350)^2);if(r<=40,1,0)'
    # function = 'if(x>=380&y>=350&x<=500&y<=400,1,0)'
  function = 'r:=sqrt(0.6*(x-400)^2+(y-200)^2);if(r<=60,1,0)'

[../]

######################    
[./eta6] # extends from y = 25 to y = 50 , x no change
variable = eta6
type = FunctionIC
#function = 'if(y>20&y<=50,1,0)'
# function = 'r1:=sqrt((x-195)^2+(y-300)^2);r2:=sqrt((x-305)^2+(y-300)^2);if(r1<=50,0,if(r2<=50,0,1))'
#function = 'r1:=sqrt((x-300)^2+(y-300)^2); r2:=sqrt((x-400)^2+(y-200)^2); r3:=sqrt((x-260)^2+(y-200)^2);r4:=sqrt((x-260)^2+(y-400)^2);r5:= sqrt((x-400)^2+(y-350)^2);  if(r1<=50,0,if(r2<=50,0,if(r3<=40,0,if(r4<=40,0,if(r5<=40,0,1)))))'
# function = 'if(x>=50&y>=100&x<=200&y<=400,0,if(x>=400&y>=180&x<=550&y<=320,0,if(x>=300&y>=120&x<=350&y<=230,0,if(x>=180&y>=430&x<=240&y<=490,0,if(x>=380&y>=350&x<=500&y<=400,0,1)))))'
function = 'r1:=sqrt(0.6*(x-200)^2+(y-150)^2); r2:=sqrt((x-280)^2+(y-380)^2); r3:=sqrt((x-210)^2+(y-490)^2);r4:=sqrt((x-420)^2+(y-400)^2);r5:= sqrt(0.6*(x-400)^2+(y-200)^2);  if(r1<=80,0,if(r2<=90,0,if(r3<=40,0,if(r4<=50,0,if(r5<=60,0,1)))))'

[../]
######################
############################################
[./ca] #Global Composition of A for ternary A-B-C alloy; A= Al
    variable = ca
    type = FunctionIC
    #function = 'r1:=sqrt((x-300)^2+(y-300)^2); r2:=sqrt((x-400)^2+(y-200)^2); r3:=sqrt((x-260)^2+(y-200)^2);r4:=sqrt((x-260)^2+(y-400)^2);r5:= sqrt((x-400)^2+(y-350)^2);  if(r1<=50,0.74,if(r2<=50,0.74,if(r3<=40,0.66,if(r4<=40,0.66,if(r5<=40,0.66,0.9)))))' 
    #######                                                                                                                                           #   Composition of Al -->  inside: eta1, eta2 (Al2Cu): 0.74;;   eta3, eta4, eta5 (Al3Ni): 0.66  and  outside: 0.9 
     #function = 'if(x>=230&y>=230&x<=370&y<=370,0.66,if(x>=380&y>=110&x<=480&y<=210,0.66,if(x>=200&y>=110&x<=300&y<=210,0.74,if(x>=160&y>=400&x<=280&y<=520,0.74,if(x>=400&y>=320&x<=520&y<=440,0.74,0.9)))))' 
    # function = 'if(x>=50&y>=100&x<=200&y<=400,0.66,if(x>=400&y>=180&x<=550&y<=320,0.66,if(x>=300&y>=120&x<=350&y<=230,0.74,if(x>=180&y>=430&x<=240&y<=490,0.74,if(x>=380&y>=350&x<=500&y<=400,0.74,0.9)))))'
     function = 'r1:=sqrt(0.6*(x-200)^2+(y-150)^2); r2:=sqrt((x-280)^2+(y-380)^2); r3:=sqrt((x-210)^2+(y-490)^2);r4:=sqrt((x-420)^2+(y-400)^2);r5:= sqrt(0.6*(x-400)^2+(y-200)^2);  if(r1<=80,0.66,if(r2<=90,0.66,if(r3<=40,0.74,if(r4<=50,0.74,if(r5<=60,0.74,0.9)))))'

     [../]

############################################  
 [./cb] #Global Composition of B for ternary A-B-C alloy; B = Ni
    variable = cb
    type = FunctionIC
    #function = 'r1:=sqrt((x-300)^2+(y-300)^2); r2:=sqrt((x-400)^2+(y-200)^2); r3:=sqrt((x-260)^2+(y-200)^2);r4:=sqrt((x-260)^2+(y-400)^2);r5:= sqrt((x-400)^2+(y-350)^2);  if(r1<=50,0.25,if(r2<=50,0.25,if(r3<=40,0.01,if(r4<=40,0.01,if(r5<=40,0.01,0.05)))))'
    #######                                                                                                                                           #   Composition of Cu -->  inside: eta1, eta2 (Al2Cu): 0.25;;   eta3, eta4, eta5 (Al3Ni): 0.01  and  outside: 0.05 
    #function = 'if(x>=230&y>=230&x<=370&y<=370,0.01,if(x>=380&y>=110&x<=480&y<=210,0.01,if(x>=200&y>=110&x<=300&y<=210,0.24,if(x>=160&y>=400&x<=280&y<=520,0.24,if(x>=400&y>=320&x<=520&y<=440,0.24,0.05)))))'
    # function = 'if(x>=50&y>=100&x<=200&y<=400,0.01,if(x>=400&y>=180&x<=550&y<=320,0.01,if(x>=300&y>=120&x<=350&y<=230,0.24,if(x>=180&y>=430&x<=240&y<=490,0.24,if(x>=380&y>=350&x<=500&y<=400,0.24,0.05)))))'  
    function = 'r1:=sqrt(0.6*(x-200)^2+(y-150)^2); r2:=sqrt((x-280)^2+(y-380)^2); r3:=sqrt((x-210)^2+(y-490)^2);r4:=sqrt((x-420)^2+(y-400)^2);r5:= sqrt(0.6*(x-400)^2+(y-200)^2);  if(r1<=80,0.01,if(r2<=90,0.01,if(r3<=40,0.25,if(r4<=50,0.25,if(r5<=60,0.25,0.05)))))'
  
    [../]                
[]
########################################################################################

[Materials]
############################################
# simple toy free energies
[./fch3]  # Al rich matrix eta6
  type = DerivativeParsedMaterial
  f_name = Fch3 #Fch3
  constant_names = 'factor_f3'
  constant_expressions = '1.0E+03' #'1.0E+08' It should be E+05 in real
  material_property_names = 'length_scale energy_scale molar_vol'
  args = 'c3a c3b'
  function = '(energy_scale/(length_scale)^3) *(-48.64 + 30*(c3a-0.9)^2+ 36*(c3b-0.05)^2 )*factor_f3/molar_vol' # The value of 0.05 rendered spurious effect at gr_b

  # function = '(energy_scale/(length_scale)^3) *(48 + 375*(c3a-0.9)^2+ 623*(c3b-0.05)^2 -480*c3a*c3b)*factor_f3/molar_vol'
  # function = '(energy_scale/(length_scale)^3) *(-20 + 5*(c3a-0.9)^3+ 1*(c3b-0.05)^3 )*factor_f3/molar_vol'
  
  outputs = exodus
[../]
######################
[./fch1] #  Al2Cu IMC eta1 eta2
  type = DerivativeParsedMaterial
  f_name = Fch1 #Fch1
  constant_names = 'factor_f1'
  constant_expressions = '1.0E+03' #'1.0E+08' '1.0E+08'
  material_property_names = 'length_scale energy_scale molar_vol'
  args = 'c1a c1b'
  #function = '(energy_scale/(length_scale)^3) *(-45 + 48*(c1a-0.66)^2+ 45*(c1b-0.01)^2)*factor_f1/molar_vol' # The value of 45 rendured quick shrinkage effect at gr_b
  function = '(energy_scale/(length_scale)^3) *(-28.95 + 48*(c1a-0.66)^2+ 45*(c1b-0.01)^2)*factor_f1/molar_vol' # The value of 0.01 rendered spurious effect at gr_b
  
  # function = '(energy_scale/(length_scale)^3) *(-45 + 240*(c1a-0.66)^2+ 409*(c1b-0.33)^2)*factor_f1/molar_vol'
  # function = '(energy_scale/(length_scale)^3) *(-45 + 12*(c1a-0.66)^2+ 1*(c1b-0.33)^2)*factor_f1/molar_vol'
  outputs = exodus
[../]
######################
[./fch2] # Al3Ni IMC eta4, eta5
  type = DerivativeParsedMaterial
  f_name = Fch2 #Fch2
  constant_names = 'factor_f2'
  constant_expressions = '1.0E+03' #'1.0E+08' '1.0E+08'
  material_property_names = 'length_scale energy_scale molar_vol'
  args = 'c2a c2b'
  function = '(energy_scale/(length_scale)^3) *(-66.05 + 49*(c2a-0.74)^2+ 50*(c2b-0.25)^2)*factor_f2/molar_vol' # -0.7
  # function = '(energy_scale/(length_scale)^3) *(-70 + 455*(c2a-0.74)^2+ 1090*(c2b-0.25)^2)*factor_f2/molar_vol' # -0.7
  # function = '(energy_scale/(length_scale)^3) *(-70 + 19.7*(c2a-0.74)^2+ 1*(c2b-0.25)^2)*factor_f2/molar_vol' # -0.7
  outputs = exodus
[../]
######################
################################################################################################################################################################################
#SwitchingFunction        ## Eq 10,11 of https://doi.org/10.1016/j.actamat.2010.10.038 A quantitative and thermodynamically Moelans 2011
   [./h1]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h1
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
        phase_etas = eta1
        #outputs = exodus
    [../]
######################
   [./h2]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h2
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
        phase_etas = eta2
        #outputs = exodus
    [../]
######################
   [./h3]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h3
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
        phase_etas = eta3
        #outputs = exodus
    [../]
######################
   [./h4]
       type = SwitchingFunctionMultiPhaseMaterial
       h_name = h4
       all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
       phase_etas = eta4
       #outputs = exodus
   [../] 
############################################
   [./h5]
       type = SwitchingFunctionMultiPhaseMaterial
       h_name = h5
       all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
       phase_etas = eta5
       #outputs = exodus
   [../] 
############################################
   [./h6]
       type = SwitchingFunctionMultiPhaseMaterial
       h_name = h6
       all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
       phase_etas = eta6
       #outputs = exodus
   [../] 
############################################
################################################################################################################################################################################
############################################    
    # Barrier functions for each phase
  [./g1]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta1
    function_name = g1
  [../]
######################
  [./g2]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta2
    function_name = g2
  [../]
######################
  [./g3]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta3
    function_name = g3
  [../]
############################################
 [./g4]
   type = BarrierFunctionMaterial
   g_order = SIMPLE
   eta = eta4
   function_name = g4
 [../]
############################################
 [./g5]
   type = BarrierFunctionMaterial
   g_order = SIMPLE
   eta = eta5
   function_name = g5
 [../]
############################################
[./g6]
  type = BarrierFunctionMaterial
  g_order = SIMPLE
  eta = eta6
  function_name = g6
[../]
############################################


############################################
# constant properties M is needed by SplitCHWRes kernel

[./scale]
      type = GenericConstantMaterial
      prop_names = 'length_scale energy_scale time_scale'
      prop_values = '1e9 6.24150943e18 1.0e9' #m to nm J to eV s to ns
  [../]

  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'pseudo_L_si   pseudo_kappa  D  M_si molar_vol'
    prop_values = '12  0.5    1  2.7851e-25 1.0e-5'  # -24 was in convergence
    #prop_values = '12  0.5    1  2.7851e-28' # M_si = 2.7851e−23 (mol·m2)/(J·s) * V (1.0e-5) https://link.springer.com/article/10.1007/s11669-021-00924-7/tables/3
  [../]
  
  [./model_constants]
    type = GenericConstantMaterial
    prop_names  = 'sigma   delta gamma'
    #prop_values = '10  25.0e-09 1.5'        # 0.5 J/m2 and delta = 5 nm and gamma is unitless
    prop_values = '0.50 35.0e-09 1.5' #'0.5  30.0e-09 1.5'        # 0.5 J/m2 and delta = 5 nm and gamma is unitless
  [../]
  
[./kappa_isotropy]
    type = ParsedMaterial
    f_name = kappa
    material_property_names = 'length_scale energy_scale sigma delta'
    function = '(energy_scale/length_scale)*(0.75*sigma*delta)' #eV/nm
  [../]
  
[./mu] # considered the same in isotropic and anisotropic
    type = ParsedMaterial
    f_name = mu
    material_property_names = 'length_scale energy_scale sigma delta'
    function = '(energy_scale/(length_scale)^3)*6*(sigma/delta)' #eV/nm^3
  [../]


  [./interface_mobility] # considered the same in isotropic and anisotropic
    type = ParsedMaterial
    #material_property_names = 'M mu kappa'
    f_name = L
    constant_names = 'factor_L'
    constant_expressions = '1.6e19'#'1.6e18' # converse at 17
    material_property_names = 'length_scale energy_scale time_scale M_si mu kappa' # We will later use M_si instead of M because of unit reasons
    function = '((length_scale)^3/(energy_scale*time_scale))*(16/3)*(mu*M_si/kappa)*factor_L' #l^3/energy*time
  [../]


  # [./ch_mobility] # considered the same in isotropic and anisotropic
  #   type = ParsedMaterial
  #   #material_property_names = 'M_si'
  #   f_name = M
  #   material_property_names = 'length_scale energy_scale time_scale M_si'
  #   function = '((length_scale)^5/(energy_scale*time_scale))*M_si' #l^5/energy*time
  # [../]


  [./ch_mobility] # considered the same in isotropic and anisotropic
  type = ParsedMaterial
  #material_property_names = 'M_si'
  f_name = M
  #args = 'eta1 eta2 eta3 eta4 eta5 eta6'
  material_property_names = 'length_scale energy_scale time_scale M_si M_gb h1 h2 h3 h4 h5 h6'
  function = '((length_scale)^5/(energy_scale*time_scale))*((h1+h2+h3+h4+h5+h6)*M_si+(h1+h2+h3+h4+h5)*(h1+h2+h3+h4+h5)*M_gb)' #l^5/energy*time
[../]

[./M_gb]
  type = ParsedMaterial
  material_property_names = 'M_si'
  f_name = M_gb
  function = '1000*M_si'
[../]

# []
############################################

####################################################################################################################################
# Elastic properties to be used in NS
# C_ijkl = '1111 1122 1133 2222 2233 3333 2323 3131 1212' for the symmetric9
# C_ijkl = '11 12 13 22 23 33 44 55 66' for the symmetric9
############################################
 [./elasticity_tensor_1]   # al2cu
    type = ComputeElasticityTensor
    base_name = C_eta1
    fill_method = symmetric9
    # C_ijkl = '1152.4 355.68 355.68 1060.8 443.04 1060.8 312 162.24 162.24'  #'1.1e6 1e5 0 1e6 0 1e6 .5e6 .2e6 .5e6'  '1152.4 355.68 355.68 1060.8 443.04 1060.8 312 162.24 162.24'
    C_ijkl = '832.44 314.00 275.87 832.44 275.87 811.40 170.62 170.62 181.69'
    [../]
  [./strain_1]  # al2cu
    type = ComputeSmallStrain
    base_name = C_eta1
    eigenstrain_names = eigenstrain
    displacements = 'disp_x disp_y'
  [../]
  [./stress_1]
    type = ComputeLinearElasticStress
    base_name = C_eta1
  [../]
  [./eigenstrain_1]
    type = ComputeEigenstrain
    base_name = C_eta1
    eigen_base = '0.0e-2' #'0.1 0.05 0 0 0 0.01'
    prefactor = -2 #pre # -1
    eigenstrain_name = eigenstrain
  [../]
#### Mew Addition
    [./pre]
      type = GenericConstantMaterial
      prop_names = pre
      #prop_values = 0.02
      prop_values = 0.002
    [../]



# 
      [./fel_eta1]      
  type = ElasticEnergyMaterial
  args = ' '
  base_name = C_eta1
  f_name = fel1
  output_properties = fel1
  outputs = exodus
[../]
############################################    

############################################
  [./elasticity_tensor_345] # Al3ni eta3, eta4, eta5
    type = ComputeElasticityTensor
    base_name = C_eta345
    fill_method = symmetric9
    # C_ijkl = '1201.92 493.44 455.52 1258.88 417.28 1172.32 493.44 411.84 398.4'  #'193e9 79e9 73e9 202e9 67e9 188e9 79e9 66e9 64e9'  #'1.1e6 1e5 0 1e6 0 1e6 .5e6 .2e6 .5e6' 
    C_ijkl = '1409.18 565.49 430.73 1507.68 479.39 1394.29 595.87 541.93 437.02'
    [../]
  [./strain_345]
    type = ComputeSmallStrain
    base_name = C_eta345
    eigenstrain_names = 'C_eigenstrain'
    displacements = 'disp_x disp_y'
  [../]
  [./stress_345]
    type = ComputeLinearElasticStress
    base_name = C_eta345
  [../]
  [./eigenstrain_345]
    type = ComputeEigenstrain
    base_name = C_eta345
    eigen_base = '0.0e-2' # '0.1 0.05 0 0 0 0.01'
    prefactor = -2
    eigenstrain_name = 'C_eigenstrain'
  [../]

    ##


    [./fel_eta345]
      type = ElasticEnergyMaterial
      args = ' '
      base_name = C_eta345
      f_name = fel2
      outputs = exodus
      output_properties = fel2
    [../]
###########################################

############################################
# base name of all ComputeElasticityTensor, ComputeSmallStrain, ComputeLinearElasticStress, ComputeEigenstrain should be same
# They are fundamentally the base codes
# The calculation presumably goes to MultiPhaseStressMaterial.
[./elasticity_tensor_6]
  type = ComputeElasticityTensor
  base_name = C_eta6 #C_eta6
  fill_method = symmetric9                                                                      # 1 ev/ang^3 = ev/(0.1 nm)^3 = 1000 ev/nm^3  = 160. 217 GPa ; 1 GPa = 6.24 eV/nm^3
  # C_ijkl = '649.44 455.52 455.52 649.44 455.52 649.44 199.68 199.68 199.68'  #'1.1e6 1e5 0 1e6 0 1e6 .5e6 .2e6 .5e6'     # youngs_modulus = 119. #19 GPa in eV/nm^3 ; 1 GPa = 119/19 = 6.26 eV/nm^3
  C_ijkl = '483.45 247.42 247.42 483.45 247.42 483.45 120.54 120.54 120.54' 
[../]                                                                                           # 
[./strain_6]
  type = ComputeSmallStrain
  base_name = C_eta6 #C_eta6
  eigenstrain_names = 'C_eigenstrain'
  displacements = 'disp_x disp_y'
[../]
[./stress_6]
  type = ComputeLinearElasticStress
  base_name = C_eta6 #C_eta6
[../]
[./eigenstrain_6]
  type = ComputeEigenstrain
  base_name = C_eta6 #C_eta6
  eigen_base = '0.0e-2' # '0.1 0.05 0 0 0 0.01'
  prefactor = -0.01
  eigenstrain_name = 'C_eigenstrain'
[../]
############################################################################################

[./fel_eta6]
  type = ElasticEnergyMaterial
  args = ' '
  base_name = C_eta6 #C_eta6
  f_name = fel3
  outputs = exodus
  output_properties = fel3
[../]
############################################
# Generate global stress from the phase stresses
  # [./combined]  # replace it with global_stress. SAME thing
  # [./combined]
  #   type = MultiPhaseStressMaterial
  #   phase_base = 'C_eta1  C_eta1  C_eta345 C_eta345 C_eta345 C_eta6'
  #   # phase_base = 'C_eta1  C_eta1  C_eta1 C_eta1 C_eta1 C_eta1'
  #   h          = 'h1 h2 h3 h4 h5 h6'
  #   base_name = global
  # [../]
    [./global_stress]
      type = MultiPhaseStressMaterial
      phase_base = 'C_eta1  C_eta1  C_eta345 C_eta345 C_eta345 C_eta6'
      # phase_base = 'C_eta1  C_eta1  C_eta1 C_eta1 C_eta1 C_eta1'
      h          = 'h1 h2 h3 h4 h5 h6'
      base_name = global
    [../]
[./global_strain]
  type = ComputeSmallStrain
  displacements = 'disp_x disp_y'
[../]

   
# This code DerivativeMultiPhaseMaterial is vestigial for the use of Fch1 + fel1 is suffient
 # Total elastic energy
#  [./Total_elastic_energy]
#   type = DerivativeMultiPhaseMaterial
#   f_name = fel_tot
#   W = 0
#   fi_names = 'fel1 fel2 fel3 fel4 fel5 fel6'
#   hi_names = 'h1 h2 h3 h4 h5 h6'
#   # gi_names = 'g1 g2 g3 g4 g5 g6'
#   etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
#   # exodus = true
#   output_properties = fel_tot
#   g = g1
# [../]

  # F1 F1 F2 F1 F2 F3
##################################
#sum chemical and elastic energies
# fel1 = fel2
# fel3 = fel4 = fel5
# fel6 is for matrix
# Therefore, three ElasticEnergyMaterial type are sufficient, 6 is redundant for code cleaning in future works.
[./F_1]
  type = DerivativeSumMaterial
  f_name = F1
  args = 'c1a c1b'
  sum_materials = 'Fch1 fel1' #'Fch1 fel1'
  #sum_materials = 'fch0'
  outputs = exodus
[../]
[./F_2]
  type = DerivativeSumMaterial
  f_name = F2
  args = 'c2a c2b'
  sum_materials = 'Fch2 fel2'
  #sum_materials = 'fch1'
  outputs = exodus
[../]
[./F_3]
  type = DerivativeSumMaterial
  f_name = F3
  args = 'c3a c3b'
  sum_materials = 'Fch3 fel3'
  #sum_materials = 'fch2'
  outputs = exodus
[../]

  # [./C]
  #   type = CompositeElasticityTensor
  #   args = 'eta1 eta2 eta3 eta4'
  #   # tensors = 'C_eta1  C_eta2  C_eta3  C_eta4  C_eta5 C_eta6'
  #   tensors = 'C_eta1  C_eta1  C_eta1  C_eta1  C_eta1 C_eta1'
  #   # weights = 'h1 h2 h3 h4 h5 h6'
  #   weights = 'h2 h2 h2 h2 h2 h2'
  # [../]

#######################################################
#  [./elasticenergyeta1]
#     type = ElasticEnergyMaterial
#     args = ' '
#     outputs = exodus
#     base_name = C_eta1
#     f_name = 'fel1'
#     use_displaced_mesh = true
#   [../]
  
#    [./elasticenergyeta2]
#     type = ElasticEnergyMaterial
#     args = ' '
#     outputs = exodus
#     base_name = C_eta2
#     f_name = 'fel2'
#     use_displaced_mesh = true
#   [../]
  
#    [./elasticenergyeta3]
#     type = ElasticEnergyMaterial
#     args = ' '
#     outputs = exodus
#     base_name = C_eta3
#     f_name = 'fel3'
#     use_displaced_mesh = true
#   [../]
  
#   # Total elastic energy
#   [./Total_elastic_energy]
#     type = DerivativeMultiPhaseMaterial
#     f_name = fel_tot
#     W = 0
#     fi_names = 'fel1 fel2 fel3'
#     hi_names = 'h1 h2 h3'
#     etas = 'eta1 eta2 eta3'
#     outputs = exodus
#     output_properties = fel_tot
#     g = g1
#     use_displaced_mesh = true
#   [../]
[]

# ########################################################################################
[Kernels]
############################################
######## First put the KKS condition with kernels of phase concentrations (local) related to cA global #######
############################################
# Phase concentration constraints
  [./chempot12a]
    type = KKSPhaseChemicalPotential
    variable = c1a
    cb       = c2a
    fa_name  = F1
    fb_name  = F2
  [../]
######################
 [./chempot23a]
   type = KKSPhaseChemicalPotential
   variable = c2a
   cb       = c3a
   fa_name  = F2
   fb_name  = F3
 [../]
############################################
 [./chempot31a]
   type = KKSPhaseChemicalPotential
   variable = c3a
   cb       = c1a
   fa_name  = F3
   fb_name  = F1
 [../]
############################################
  [./phaseconcentration_a]
    type = KKSMultiPhaseConcentration
    variable = c3a  # converses with c2a
    cj = 'c1a c1a c2a c2a c2a c3a'
    hj_names = 'h1 h2 h3 h4 h5 h6'
    etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
    c = ca
  [../]
############################################
############################################
######## First put the KKS condition for kernels of phase concentrations (local) related to cB global #######
############################################
# Phase concentration constraints
  [./chempot12b]
    type = KKSPhaseChemicalPotential
    variable = c1b
    cb       = c2b
    fa_name  = F1
    fb_name  = F2
  [../]
######################
 [./chempot23b]
   type = KKSPhaseChemicalPotential
   variable = c2b
   cb       = c3b
   fa_name  = F2
   fb_name  = F3
 [../]
############################################
 [./chempot31b]
   type = KKSPhaseChemicalPotential
   variable = c3b
   cb       = c1b
   fa_name  = F3
   fb_name  = F1
 [../]
############################################
  [./phaseconcentration_b]
    type = KKSMultiPhaseConcentration
    variable = c3b
    cj = 'c1b c1b c2b c2b c2b c3b'
    hj_names = 'h1 h2 h3 h4 h5 h6'
    etas = 'eta1 eta2 eta3 eta4 eta5 eta6'
    c = cb
  [../]
############################################

# ######## First put the KKS condition for kernels of phase concentrations (local) related to cC global #######
# ############################################
# # Phase concentration constraints
# [./chempot12c]
#   type = KKSPhaseChemicalPotential
#   variable = c1c
#   cb       = c2c
#   fa_name  = F1
#   fb_name  = F2
# [../]
# ######################
# ######################
# #  [./chempot23c]
# #    type = KKSPhaseChemicalPotential
# #    variable = c2c
# #    cb       = c3c
# #    fa_name  = F2
# #    fb_name  = F1
# #  [../]
# ############################################
# ######################
# #  [./chempot31c]
# #    type = KKSPhaseChemicalPotential
# #    variable = c3c
# #    cb       = c1c
# #    fa_name  = F1
# #    fb_name  = F1
# #  [../]
# ############################################
# ############################################
# [./phaseconcentration_c]
#   type = KKSMultiPhaseConcentration
#   variable = c2c
#   cj = 'c1c c2c c1c'
#   hj_names = 'h1 h2 h3'
#   etas = 'eta1 eta2 eta3'
#   c = cc
# [../]
# ############################################
############################################
## Kernels for split Cahn-Hilliard type equation
    ## CHBulk known as KKSSplitCHCRes is here to replace SplitCHParsed
    ## because in KKS model , gradient energy term is not allowed in the C-H type equation [Tonks2018-ComputationalMaterialsScience,vol. 147, pp.353-362.]
    ## while SplitCHParsed kernel consists of the term k\nabla^2 c_i (thus making it unsuitable here), KKSSplitCHCRes fortunately avoids this term.
    ## Never use SplitCHParsed kernel with KKS model
    ## Because of the KKS condition 1 (equality of chemical potential between any two adjacent phases), one KKSSplitCHCRes kernel (either for c1, c2 or c3) is sufficient and there is no need to put three such kernels corresponding to c1, c2 and c3.

##############################################################################3  
# Diffusion kernels corresponding to phase concentrations of global cA
########################################################################  
    [./CHBulka] # Gives the residual for the concentration, dF/dc-mu
        type = KKSSplitCHCRes
        variable = ca
        ca       = c2a
        fa_name  = F2 #only F2 is used
        w        = wa
    [../]
############################################
    [./dcdta] # Gives dc/dt
        type = CoupledTimeDerivative
        variable = wa
        v = ca
    [../]
############################################   
    [./ckernela] # Gives residual for chemical potential dc/dt+M\grad(mu)
        type = SplitCHWRes
        mob_name = M
        variable = wa
        args = 'eta1 eta2 eta3 eta4 eta5 eta6'
    [../]
############################################
 
# Diffusion kernels corresponding to phase concentrations of global cB
########################################################################  
    [./CHBulkb] # Gives the residual for the concentration, dF/dc-mu
        type = KKSSplitCHCRes
        variable = cb
        ca       = c2b
        fa_name  = F2 #only F2 is used
        w        = wb
    [../]
############################################
    [./dcdtb] # Gives dc/dt
        type = CoupledTimeDerivative
        variable = wb
        v = cb
    [../]
############################################   
    [./ckernelb] # Gives residual for chemical potential dc/dt+M\grad(mu)
        type = SplitCHWRes
        mob_name = M
        variable = wb
        args = 'eta1 eta2 eta3 eta4 eta5 eta6'
    [../]
##################################################################

  # Kernels for Allen-Cahn equation for eta1
######################  
  [./deta1dt]
    type = TimeDerivative
    variable = eta1
  [../]
######################################################################################################################################
###################################################################################################################
  [./ACBulkF1]
    type = KKSMultiACBulkF
    variable  = eta1
    Fj_names  = 'F1 F1 F2 F2 F2 F3'   # F3 is for Al-rich FCC i.e eta6.
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    gi_name   = g1
    eta_i     = eta1
    wi        = 10.0 #1
    args      = 'c1a c2a c1b c2b c3a c3b eta2 eta3 eta4 eta5 eta6'
    mob_name = L
  [../]
######################
###############################################################################################################
# In ACBulkC1, the kernel requires  the definition of a particular element (A or B) as a separate list of vectors
################################################################################################################
  [./ACBulkC1a]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1a c1a c2a c2a c2a c3a'
    eta_i     = eta1
    args      = 'eta2 eta3 eta4 eta5 eta6'
    mob_name = L
  [../]
######################
 [./ACBulkC1b]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1b c1b c2b c2b c2b c3b'
    eta_i     = eta1
    args      = 'eta2 eta3 eta4 eta5 eta6'
    mob_name = L
  [../]
######################
# [./ACBulkC1c]
#   type = KKSMultiACBulkC
#   variable  = eta1
#   Fj_names  = 'F1 F1 F2 F2 F2 F3'
#   hj_names  = 'h1 h2 h3 h4 h5 h6'
#   cj_names  = 'c1a c1a c2a c2a c2a c3a'
#   eta_i     = eta1
#   args      = 'eta2 eta3 eta4 eta5 eta6'
#   mob_name = L
# [../]
###################################################################################################################################### 
  [./ACInterface1]
    type = ACInterface
    variable = eta1
    kappa_name = kappa
    mob_name = L
  [../]
  
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta1] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta1
      v = 'eta2 eta3 eta4 eta5 eta6'
      gamma_names = 'gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta2 eta3 eta4 eta5 eta6'
[../]  

##################################################################

  # Kernels for Allen-Cahn equation for eta2
  
######################
  [./deta2dt]
    type = TimeDerivative
    variable = eta2
  [../]
######################  
  [./ACBulkF2]
    type = KKSMultiACBulkF
    variable  = eta2
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    gi_name   = g2
    eta_i     = eta2
    wi        = 10.0 #1
    args      = 'c1a c2a c1b c2b c3a c3b eta1 eta3 eta4 eta5 eta6'
    mob_name = L
  [../]

######################
  [./ACBulkC2a]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1a c1a c2a c2a c2a c3a'
    eta_i     = eta2
    args      = 'eta1 eta3 eta4 eta5 eta6' 
    mob_name = L
  [../]
######################
 [./ACBulkC2b]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1b c1b c2b c2b c2b c3b'
    eta_i     = eta2
    args      = 'eta1 eta3 eta4 eta5 eta6'
    mob_name = L
  [../]
# ######################
# [./ACBulkC2c]
#   type = KKSMultiACBulkC
#   variable  = eta2
#   Fj_names  = 'F1 F2 F1'
#   hj_names  = 'h1 h2 h3'
#   cj_names  = 'c1c c2c c1c'
#   eta_i     = eta2
#   args      = 'eta1 eta3'
#   mob_name = L
# [../]

######################  
  [./ACInterface2]
    type = ACInterface
    variable = eta2
    kappa_name = kappa
    mob_name = L
  [../]
  
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta2] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta2
      v = 'eta1 eta3 eta4 eta5 eta6'
      gamma_names = 'gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta4 eta5 eta6'
[../]    
####################################################################################################################################

# Kernels for Allen-Cahn equation for eta3
######################
  [./deta3dt]
    type = TimeDerivative
    variable = eta3
  [../]
######################
  [./ACBulkF3]
    type = KKSMultiACBulkF
    variable  = eta3
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    gi_name   = g3
    eta_i     = eta3
    wi        = 10.0 #1
    args      = 'c1a c2a c1b c2b c3a c3b eta1 eta2 eta4 eta5 eta6'
    mob_name = L
  [../]
######################
  [./ACBulkC3a]
    type = KKSMultiACBulkC
    variable  = eta3
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1a c1a c2a c2a c2a c3a'
    eta_i     = eta3
    args      = 'eta1 eta2 eta4 eta5 eta6'
    mob_name = L
  [../]
######################
 [./ACBulkC3b]
    type = KKSMultiACBulkC
    variable  = eta3
    Fj_names  = 'F1 F1 F2 F2 F2 F3'
    hj_names  = 'h1 h2 h3 h4 h5 h6'
    cj_names  = 'c1b c1b c2b c2b c2b c3b'
    eta_i     = eta3
    args      = 'eta1 eta2 eta4 eta5 eta6'
    mob_name = L
  [../]
######################  
  [./ACInterface3]
    type = ACInterface
    variable = eta3
    kappa_name = kappa
    mob_name = L
  [../]
  
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta3] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta3
      v = 'eta1 eta2 eta4 eta5 eta6'
      gamma_names = 'gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta2 eta4 eta5 eta6'
[../]    
####################################################################################################################################

# Kernels for Allen-Cahn equation for eta4
######################
[./deta4dt]
  type = TimeDerivative
  variable = eta4
[../]
######################
[./ACBulkF4]
  type = KKSMultiACBulkF
  variable  = eta4
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  gi_name   = g4
  eta_i     = eta4
  wi        = 10.0 #1
  args      = 'c1a c2a c1b c2b c3a c3b eta1 eta2 eta3 eta5 eta6'
  mob_name = L
[../]
######################
[./ACBulkC4a]
  type = KKSMultiACBulkC
  variable  = eta4
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1a c1a c2a c2a c2a c3a'
  eta_i     = eta4
  args      = 'eta1 eta2 eta3 eta5 eta6'
  mob_name = L
[../]
######################
[./ACBulkC4b]
  type = KKSMultiACBulkC
  variable  = eta4
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1b c1b c2b c2b c2b c3b'
  eta_i     = eta4
  args      = 'eta1 eta2 eta3 eta5 eta6'
  mob_name = L
[../]
######################  
[./ACInterface4]
  type = ACInterface
  variable = eta4
  kappa_name = kappa
  mob_name = L
[../]

# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta4] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
    type = ACGrGrMulti
    variable = eta4
    v = 'eta1 eta2 eta3 eta5 eta6'
    gamma_names = 'gamma gamma gamma gamma gamma'
    mob_name = L
    args = 'eta1 eta2 eta3 eta5 eta6'
[../]    
####################################################################################################################################

# Kernels for Allen-Cahn equation for eta5
######################
[./deta5dt]
  type = TimeDerivative
  variable = eta5
[../]
######################
[./ACBulkF5]
  type = KKSMultiACBulkF
  variable  = eta5
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  gi_name   = g5
  eta_i     = eta5
  wi        = 10.0 #1
  args      = 'c1a c2a c1b c2b c3a c3b eta1 eta2 eta3 eta4 eta6'
  mob_name = L
[../]
######################
[./ACBulkC5a]
  type = KKSMultiACBulkC
  variable  = eta5
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1a c1a c2a c2a c2a c3a'
  eta_i     = eta5
  args      = 'eta1 eta2 eta3 eta4 eta6'
  mob_name = L
[../]
######################
[./ACBulkC5b]
  type = KKSMultiACBulkC
  variable  = eta5
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1b c1b c2b c2b c2b c3b'
  eta_i     = eta5
  args      = 'eta1 eta2 eta3 eta4 eta6'
  mob_name = L
[../]
######################  
[./ACInterface5]
  type = ACInterface
  variable = eta5
  kappa_name = kappa
  mob_name = L
[../]

# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta5] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
    type = ACGrGrMulti
    variable = eta5
    v = 'eta1 eta2 eta3 eta4 eta6'
    gamma_names = 'gamma gamma gamma gamma gamma'
    mob_name = L
    args = 'eta1 eta2 eta3 eta4 eta6'
[../]    
####################################################################################################################################

# Kernels for Allen-Cahn equation for eta6
######################
[./deta6dt]
  type = TimeDerivative
  variable = eta6
[../]
######################
[./ACBulkF6]
  type = KKSMultiACBulkF
  variable  = eta6
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  gi_name   = g6
  eta_i     = eta6
  wi        = 10.0 #1
  args      = 'c1a c2a c1b c2b c3a c3b eta1 eta2 eta3 eta4 eta5'
  mob_name = L
[../]
######################
[./ACBulkC6a]
  type = KKSMultiACBulkC
  variable  = eta6
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1a c1a c2a c2a c2a c3a'
  eta_i     = eta6
  args      = 'eta1 eta2 eta3 eta4 eta5'
  mob_name = L
[../]
######################
[./ACBulkC6b]
  type = KKSMultiACBulkC
  variable  = eta6
  Fj_names  = 'F1 F1 F2 F2 F2 F3'
  hj_names  = 'h1 h2 h3 h4 h5 h6'
  cj_names  = 'c1b c1b c2b c2b c2b c3b'
  eta_i     = eta6
  args      = 'eta1 eta2 eta3 eta4 eta5'
  mob_name = L
[../]
######################  
[./ACInterface6]
  type = ACInterface
  variable = eta6
  kappa_name = kappa
  mob_name = L
[../]

# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta6] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
    type = ACGrGrMulti
    variable = eta6
    v = 'eta1 eta2 eta3 eta4 eta5'
    gamma_names = 'gamma gamma gamma gamma gamma'
    mob_name = L
    args = 'eta1 eta2 eta3 eta4 eta5'
[../]    
####################################################################################################################################
# For elasticity
# Kernel for NS

  [./TensorMechanics]
   displacements = 'disp_x disp_y'
   base_name=global
   # 2 new lines form Puffin 2d
   planar_formulation = PLANE_STRAIN
   use_displaced_mesh = false
  [../]
########################################################################################
[]

######################################################################################################################################################
[AuxKernels]
[./bnds]
    type = BndsCalcAux
    variable = bnds
    var_name_base = eta
    op_num = 6 #2
    v = 'eta1 eta2 eta3 eta4 eta5 eta6'
  [../]
############################################
  [./Energy_total]
    type = KKSMultiFreeEnergy
    Fj_names = 'F1 F1 F2 F2 F2 F3'
    hj_names = 'h1 h2 h3 h4 h5 h6'
    gj_names = 'g1 g2 g3 g4 g5 g6'
    variable = Energy
    w = 1
    interfacial_vars =  'eta1 eta2 eta3 eta4 eta5 eta6'
    kappa_names =       'kappa kappa kappa kappa kappa kappa'
  [../]
############################################

[./ca_hsquarec]
      type = SixPhasesSumCdothsquare
      variable = gr_ca
      var1 = ca
      h1_name = h1
      h2_name = h2
      h3_name = h3
      h4_name = h4
      h5_name = h5
      h6_name = h6
      #h4_name = h_ni
    [../]

[./cb_hsquarec]
      type = SixPhasesSumCdothsquare
      variable = gr_cb
      var1 = cb
      h1_name = h1
      h2_name = h2
      h3_name = h3
      h4_name = h4
      h5_name = h5
      h6_name = h6      
      #h4_name = h_ni
    [../]

# [./cc_hsquarec]
#       type = SumThreeCdothsquare
#       variable = gr_cc
#       var1 = cc
#       h1_name = h1
#       h2_name = h2
#       h3_name = h3
#       #h4_name = h_ni
#     [../]   

#################################################
# # Stress due to elasticity

[./von_mises_kernel]
  #Calculates the von mises stress and assigns it to von_mises
  type = RankTwoScalarAux
  variable = von_mises
  rank_two_tensor =global_stress
  execute_on = timestep_end
  scalar_type = VonMisesStress #TODO: Check units
[../]
[./matl_sigma11]
  type = RankTwoAux
  rank_two_tensor = global_stress
  index_i = 0
  index_j = 0
  variable = sigma11
[../]
[./matl_sigma22]
  type = RankTwoAux
  rank_two_tensor = global_stress
  index_i = 1
  index_j = 1
  variable = sigma22
[../]
[./matl_sigma12]
  type = RankTwoAux
  rank_two_tensor = global_stress
  index_i = 0
  index_j = 1
  variable = sigma12
[../]
[./matl_e11]
  type = RankTwoAux
  rank_two_tensor = total_strain
  index_i = 0
  index_j = 0
  variable = e11
[../]
[./matl_e12]
  type = RankTwoAux
  rank_two_tensor = total_strain
  index_i = 0
  index_j = 1
  variable = e12
[../]
[./matl_e22]
  type = RankTwoAux
  rank_two_tensor = total_strain
  index_i = 1
  index_j = 1
  variable = e22
[../]

[]
########################################################################################

[Postprocessors]
  [area_al_eta6]
    type = ElementIntegralMaterialProperty
    mat_prop = h6
    execute_on = 'Initial TIMESTEP_END'
  []
  [area_al2cu_eta1]
    type = ElementIntegralMaterialProperty
    mat_prop = h1
    execute_on = 'Initial TIMESTEP_END'
  []
  [area_al2cu_eta2]
    type = ElementIntegralMaterialProperty
    mat_prop = h2
    execute_on = 'Initial TIMESTEP_END'
  []
  [area_al3ni_eta3]
    type = ElementIntegralMaterialProperty
    mat_prop = h3
    execute_on = 'Initial TIMESTEP_END'
  []
  [area_al3ni_eta4]
    type = ElementIntegralMaterialProperty
    mat_prop = h4
    execute_on = 'Initial TIMESTEP_END'
  []
  [area_al3ni_eta5]
    type = ElementIntegralMaterialProperty
    mat_prop = h5
    execute_on = 'Initial TIMESTEP_END'
  []
[]



[Executioner]
############################################
  type = Transient
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -sub_pc_type   -sub_pc_factor_shift_type'
  petsc_options_value = 'asm       ilu            nonzero'
  l_max_its = 50
  nl_max_its = 20
  l_tol = 1.0e-4
  nl_rel_tol = 1.0e-10 #1.0e-10
  nl_abs_tol = 1.0e-11 #1.0e-11

  #num_steps = 200 #45 #2
  #dt = 1.0E-02 #0.5
  end_time = 6.00E+20
############################################
[./TimeStepper]
    ## Turn on time stepping
    type = IterationAdaptiveDT
    dt = 1.00E5 #06
    cutback_factor = 0.8
    growth_factor = 1.1 #1.5
    optimal_iterations = 7
    #num_steps = 55
[../]
############################################
############################################
# adaptive mesh to resolve an interface
   [./Adaptivity]
     interval              = 5                      # Adaptivity is performed so that it is performed on every _nth_ step
     initial_adaptivity    = 4 #3 #3 #2             # Number of times mesh is adapted to initial condition
     refine_fraction       = 0.9 #0.7               # Fraction of high error that will be refined
     coarsen_fraction      = 0.1 #0.1               # Fraction of low error that will coarsened
     max_h_level           = 2 #3 #3 #2 #3          # Max number of refinements used, starting from initial mesh (before uniform refinement)
     weight_names          = 'eta1 eta2 eta3 eta4 eta5 eta6'
     weight_values         = '1 1 1 1 1 1'
   [../]
[]
########################################################################################

[Preconditioning]
############################################
  active = 'full'
  [./full]
    type = SMP
    full = true
  [../]
  [./mydebug]
    type = FDP
    full = true
  [../]
############################################

[]

########################################################################################
[Outputs]
############################################
  exodus = true
  csv  = true
  file_base = exodus_files/final/Al-Cu-Ni_el_0.0/Al_Cu_Ni_el_0.0
  interval = 5 #20 #50
  checkpoint = true
############################################
 #[./my_checkpoint]
  #  type = Checkpoint
  #  num_files = 4
  #  interval = 1 #5
 # [../]

[]

########################################################################################

[Debug]
  show_var_residual_norms = true
[]
