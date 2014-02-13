//
//  FirstViewController.m
//  Leccion #4
//
//  Created by Maikol Araya on 2/12/14.
//  Copyright (c) 2014 La Creativeria. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    database = [[DAO alloc] retrieveSinglenton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)btnAddToDataBase:(id)sender {
    
    //1. Tomar el valor del textField
    if ([database addPersonToDataBase:self.txtName.text]) {
        NSLog(@"Agregado");
    }
    else {
        NSLog(@"Ocurrió un error");
    }
    //2. Insertar el valor en la base de datos
    //3. Mostrar un mensaje de notificación
}
@end





















