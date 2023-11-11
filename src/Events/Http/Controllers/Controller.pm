package Events::Http::Controllers::Controller;

use strict;
use warnings;

use Foundation::Appify;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub welcome {
    my $self = shift;
    my $request = shift;

    app()->pushToStack('scripts', servicePath('events') . '/script.js');

    my $template = &_::template('events::welcome', {

        isAdmin => user()->isAdmin(),
        adminRoute => '/apps/events/admin',
    });

    return $template->output();
}

sub dashboard {
    my $self = shift;
    my $request = shift;

    my $template = &_::template('events::dashboard', {
        isAdmin => user()->get('eventAdmin'),
    });

    return $template->output();

    return '';
}

1;
