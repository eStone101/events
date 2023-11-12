package Events::Http::Controllers::Controller;

use Events::Actions::CreateEvent;
use Events::Repositories::EventRepository;

use strict;
use warnings;

use Foundation::Appify;
use Data::Dumper;

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

    my $EventRepository = Events::Repositories::EventRepository->new();
    my $upcomingEvents =  $EventRepository->getUpcomingEvents();

    die Dumper(@$upcomingEvents[0]);

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

sub create {
    my $self = shift;
    my $request = shift;

    my $CreateEvent = Events::Actions::CreateEvent->new();

    $CreateEvent->handle($request);

    my $template = &_::template('events::dashboard', {
        isAdmin => user()->get('eventAdmin'),
    });

    return $template->output();
}

sub show {
    my $self = shift;
    my $request = shift;

    die $request->param('id');

    my $template = &_::template('events::show', {
        
    });

    return $template->output();
}

1;
