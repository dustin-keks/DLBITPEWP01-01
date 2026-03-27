import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AGB } from './agb';

describe('AGB', () => {
  let component: AGB;
  let fixture: ComponentFixture<AGB>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AGB]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AGB);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
