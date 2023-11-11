#!/usr/bin/perl

use strict;
use warnings;

use Http::Route;
use Events::Http::Controllers::Controller;

use Foundation::Appify;

use Data::Dumper;

Http::Route::group({

    middlewares => [

        # Check if the visitor is signed in.
        'Http::Middlewares::Auth',
        
        # TODO: Implement service middleware classes instead of only using
        # TODO: closures.
        sub {
            my $request = shift;
            my $next = shift;

            return &$next($request); 
        }

    ],

}, sub {

    # Routes within this scope require the visitor to be signed in.

    Http::Route::group({

        # The prefix of the http route.
        prefix => '/apps/events',

        # The prefix of the route name.
        as => 'apps.events.',

    }, sub {
        
        Http::Route::get('/', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Events::Http::Controllers::Controller->new()->welcome(
                $request,
            );

        }),

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/admin',

            # The prefix of the route name.
            as => 'admin.',

            middlewares => [
                
                sub {
                    my $request = shift;
                    my $next = shift;
           

                    return &$next($request); 
                }

            ],

        }, sub {
            
            Http::Route::get('/', sub {

                my $request = shift;

                return Events::Http::Controllers::Controller->new()->dashboard(
                    $request,
                );

            }),

        });

    });


});
